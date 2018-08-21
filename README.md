## Build images

Clone repository:

```
git clone https://github.com/AlekseyChudov/docker-images.git
cd docker-images
```

Build all images and tag them as **latest** (default):

```
make
```

Push all **latest** (default) images to registry:

```
make push
```

Pull all **latest** (default) images from registry and tag them as **mytag**:

```
make tag -e SET_TAG=mytag
```

Push all **mytag** images to registry:

```
make push -e TAG=mytag
```

Build single image and tag it as **latest** (default):

```
make -e IMAGES=centos7-systemd
```

Push single **latest** (default) image to registry:

```
make push -e IMAGES=centos7-systemd
```

Pull single **latest** (default) image from registry and tag is as **mytag**:

```
make tag -e IMAGES=centos7-systemd -e SET_TAG=mytag
```

Push single **mytag** image to registry:

```
make push -e IMAGES=centos7-systemd -e TAG=mytag
```
