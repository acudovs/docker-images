FROM docker.io/centos:7
ENV container docker
CMD ["/usr/lib/systemd/systemd"]
STOPSIGNAL SIGRTMIN+3

ARG TZ=Europe/Riga

COPY rootfs /
RUN /docker.build
