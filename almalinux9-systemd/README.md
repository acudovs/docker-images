AlmaLinux 9 based systemd image https://hub.docker.com/r/alekseychudov/almalinux9-systemd

# How to run AlmaLinux 9 systemd container

## Podman containter

```
podman run -it docker.io/alekseychudov/almalinux9-systemd
```

## Docker containter

```
docker run -it --tmpfs /run --tmpfs /tmp -v /sys/fs/cgroup:/sys/fs/cgroup:ro docker.io/alekseychudov/almalinux9-systemd
```
