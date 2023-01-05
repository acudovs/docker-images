#!/usr/bin/env -S bash -ex

from="docker.io/library/oraclelinux:8"
name="${REGISTRY}/${IMAGE}:${SET_TAG}"

# Create working container
working_container="$(buildah from --pull-always "${from}")"

# Customize working container
buildah config --cmd "/usr/lib/systemd/systemd" "${working_container}"
buildah config --env "container=docker" "${working_container}"
buildah config --stop-signal "SIGRTMIN+3" "${working_container}"

buildah run "${working_container}" -- bash -cex '
yum -y install epel-release
yum -y update
yum -y install bash-completion bind-utils glibc-langpack-en iproute iputils less lsof net-tools procps-ng psmisc telnet tcpdump

cp /etc/skel/.bashrc /root/
echo alias ..=\"cd ..\" >> /root/.bashrc
echo alias l=\"ls -alF --color=auto\" >> /root/.bashrc

# Setup systemd
rm -frv /etc/systemd/system/*.wants /usr/lib/systemd/system/*.wants/*
ln -rsvt /usr/lib/systemd/system/sockets.target.wants /usr/lib/systemd/system/dbus.socket
ln -rsvt /usr/lib/systemd/system/sockets.target.wants /usr/lib/systemd/system/systemd-journald.socket
ln -rsvt /usr/lib/systemd/system/sockets.target.wants /usr/lib/systemd/system/systemd-shutdownd.socket
ln -rsvt /usr/lib/systemd/system/sysinit.target.wants /usr/lib/systemd/system/systemd-tmpfiles-setup.service
ln -rsvt /usr/lib/systemd/system/timers.target.wants /usr/lib/systemd/system/systemd-tmpfiles-clean.timer

# Do not require umount.target to prevent shutdown errors
for service in /usr/lib/systemd/system/*.service; do
    if test -f "${service}" && grep -q "Requires=.*umount.target" "${service}"; then
        sed -i "/Requires=.*umount.target/s/ *umount.target//g" "${service}"
    fi
done

# Final cleaning
yum clean all
rm -frv /tmp/* /var/cache/dnf /var/log/* /var/tmp/*
find /etc -name "*-" -o -name "*.bak" -o -name "*.rpmnew" -o -name "*.rpmsave" | xargs rm -fv
'

# Commit working container to an image
buildah commit --format docker --rm --squash "${working_container}" "${name}"
