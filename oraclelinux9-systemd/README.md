Oracle Linux 9 based systemd image https://hub.docker.com/r/alekseychudov/oraclelinux9-systemd

# How to run Oracle Linux 9 systemd container

## Podman containter

```
podman run -it docker.io/alekseychudov/oraclelinux9-systemd
```

## Docker containter

```
docker run -it --tmpfs /run --tmpfs /tmp -v /sys/fs/cgroup:/sys/fs/cgroup:ro docker.io/alekseychudov/oraclelinux9-systemd
```
