FROM docker.io/fedora:28
CMD /usr/sbin/sshd -D -o AllowUsers=clipgrab -o PermitEmptyPasswords=yes

ENV LANG=en_US.UTF-8

ARG CLIPGRAB_VERSION=3.6.9

COPY rootfs /
RUN /docker.build
