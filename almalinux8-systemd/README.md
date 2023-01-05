AlmaLinux 8 based systemd image https://hub.docker.com/r/alekseychudov/almalinux8-systemd

# How to run AlamaLinux 8 systemd container

## Podman containter

```
podman run -it docker.io/alekseychudov/almalinux8-systemd
```

## Docker containter

```
docker run -it --tmpfs /run --tmpfs /tmp -v /sys/fs/cgroup:/sys/fs/cgroup:ro docker.io/alekseychudov/almalinux8-systemd
```
