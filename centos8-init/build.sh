#!/usr/bin/env -S bash -ex

export REGISTRY_AUTH_FILE="/etc/containers/auth.json"

# Workaround until original CentOS 8 image is available
from="${1:-registry.access.redhat.com/ubi8/ubi-init:latest}"
tag="${2:-docker.io/alekseychudov/centos8-init:latest}"

container="$(buildah from --pull-always "${1:-$from}")"

buildah run "${container}" -- bash -c '
# Transform RHEL 8 to CentOS 8
rpm -e --nodeps redhat-release
rm -fv /etc/yum.repos.d/*
rpm -Uvh http://mirror.centos.org/centos/8.0.1905/BaseOS/x86_64/os/Packages/centos-release-8.0-0.1905.0.9.el8.x86_64.rpm
yum -y remove "*subscription-manager*"
yum -y install epel-release
yum -y update

# Additional settings
yum -y install bash-completion bind-utils iproute less lsof net-tools psmisc telnet tcpdump
cp /etc/skel/.bashrc /root/
echo alias l=\"ls -lAF\" >> /root/.bashrc

# Final cleaning
yum clean all
rm -frv /tmp/* /var/cache/dnf /var/log/* /var/tmp/*
find /etc -name "*-" -o -name "*.bak" -o -name "*.rpmnew" -o -name "*.rpmsave" | xargs rm -fv
'

# Commit container to an image
buildah commit --rm --squash "${container}" "${tag}"

# Push image to registry
buildah push --authfile "${REGISTRY_AUTH_FILE}" "${tag}"
