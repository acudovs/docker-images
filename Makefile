# Ordered list of images to build (override with "-e" command line option)
IMAGES = \
	centos7-systemd \
	centos7-build \
	oraclelinux8-systemd \
	oraclelinux8-build

REGISTRY = docker.io/alekseychudov
FROM_TAG = latest
SET_TAG = latest
UMASK = 0022

.PHONY: $(IMAGES) images pull push tag clean-all clean-build clean-containers clean-images

images:
	export REGISTRY=$(REGISTRY) FROM_TAG=$(FROM_TAG) SET_TAG=$(SET_TAG); \
	umask $(UMASK); \
	for image in $(IMAGES); do \
		export IMAGE=$${image}; \
		$${image}/build.sh; \
	done

pull:
	for image in $(IMAGES); do \
		podman pull "$(REGISTRY)/$${image}:$(FROM_TAG)"; \
	done

push:
	for image in $(IMAGES); do \
		podman push "$(REGISTRY)/$${image}:$(FROM_TAG)"; \
	done

tag: pull
	for image in $(IMAGES); do \
		podman tag "$(REGISTRY)/$${image}:$(FROM_TAG)" "$(REGISTRY)/$${image}:$(SET_TAG)"; \
	done

clean-build:

clean-containers:
	podman rm --all --force

clean-images:
	podman rmi --all --force

clean-all: clean-build clean-containers clean-images
