## Build images

Clone repository:

```
git clone https://github.com/AlekseyChudov/docker-images.git
cd docker-images
```

Build all images and tag them as **staging** (default):

```
make
```

Push all **staging** (default) images to registry:

```
make push
```

Pull all **staging** (default) images from registry and tag them as **latest**:

```
make tag -e SET_TAG=latest
```

Push all **latest** images to registry:

```
make push -e TAG=latest
```

Build single image and tag it as **staging** (default):

```
make -e IMAGES=centos7-systemd
```

Push single **staging** (default) image to registry:

```
make push -e IMAGES=centos7-systemd
```

Pull single **staging** (default) image from registry and tag is as **latest**:

```
make tag -e IMAGES=centos7-systemd -e SET_TAG=latest
```

Push single **latest** image to registry:

```
make push -e IMAGES=centos7-systemd -e TAG=latest
```
