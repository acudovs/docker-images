#!/usr/bin/env -S bash -ex

from="${REGISTRY}/oraclelinux8-systemd:${FROM_TAG}"
name="${REGISTRY}/${IMAGE}:${SET_TAG}"

# Create working container
working_container="$(buildah from --pull "${from}")"

# Customize working container
buildah run "${working_container}" -- bash -cex '
yum -y update
yum -y install "@Development Tools" vim-enhanced

echo alias vi=\"vim\" >> /root/.bashrc

# Final cleaning
yum clean all
rm -frv /tmp/* /var/cache/dnf /var/log/* /var/tmp/*
find /etc -name "*-" -o -name "*.bak" -o -name "*.rpmnew" -o -name "*.rpmsave" | xargs rm -fv
'

# Commit working container to an image
buildah commit --format docker --rm --squash "${working_container}" "${name}"
