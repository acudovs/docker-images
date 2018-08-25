## fedora28-clipgrab

ClipGrab is a free downloader and converter for YouTube, Vimeo, Facebook and
many other online video sites https://clipgrab.org/.

Run

```
docker run -d --name clipgrab --hostname clipgrab docker.io/alekseychudov/fedora28-clipgrab
```

Connect

```
ssh -X clipgrab@$(docker inspect clipgrab --format "{{ .NetworkSettings.IPAddress }}")
```
