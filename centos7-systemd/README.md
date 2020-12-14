CentOS 7 based systemd image https://hub.docker.com/r/alekseychudov/centos7-systemd

# How to run CentOS 7 systemd container

## Podman containter

```
podman run -it docker.io/alekseychudov/centos7-systemd
```

## Docker containter

```
docker run -it --tmpfs /run --tmpfs /tmp -v /sys/fs/cgroup:/sys/fs/cgroup:ro docker.io/alekseychudov/centos7-systemd
```
