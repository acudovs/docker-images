#!/usr/bin/env -S bash -x

export REGISTRY_AUTH_FILE="/etc/containers/auth.json"

from="${1:-docker.io/alekseychudov/centos8-init:latest}"
tag="${2:-docker.io/alekseychudov/centos8-devel:latest}"

container="$(buildah from --pull-always "${1:-$from}")"

buildah run "${container}" -- bash -c '
yum -y update
yum -y install "@Development Tools" vim-enhanced wget
yum clean all
rm -frv /tmp/* /var/cache/yum /var/log/* /var/tmp/*
find /etc -name "*-" -o -name "*.bak" -o -name "*.rpmnew" -o -name "*.rpmsave" | xargs rm -fv
'

# Commit container to an image
buildah commit --rm --squash "${container}" "${tag}"

# Push image to registry
buildah push --authfile "${REGISTRY_AUTH_FILE}" "${tag}"
