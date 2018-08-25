IMAGES = \
	centos7-systemd \
	centos7-build \
	centos7-corosync-qnetd \
	fedora28-clipgrab

REGISTRY = docker.io/alekseychudov
FROM_TAG = latest
SET_TAG = latest
UMASK = 0022

.PHONY: $(IMAGES) images pull push tag clean-all clean-build clean-containers clean-images

images:
	umask $(UMASK); \
	for image in $(IMAGES); do \
		sed 's|$$(REGISTRY)|$(REGISTRY)|g; s|$$(FROM_TAG)|$(FROM_TAG)|g' "$${image}/Dockerfile" > "$${image}/.Dockerfile.build"; \
		docker build --force-rm --no-cache -t "$(REGISTRY)/$${image}:$(SET_TAG)" -f "$${image}/.Dockerfile.build" "$${image}"; \
	done

pull:
	for image in $(IMAGES); do \
		docker pull "$(REGISTRY)/$${image}:$(FROM_TAG)"; \
	done

push:
	for image in $(IMAGES); do \
		docker push "$(REGISTRY)/$${image}:$(FROM_TAG)"; \
	done

tag: pull
	for image in $(IMAGES); do \
		docker tag "$(REGISTRY)/$${image}:$(FROM_TAG)" "$(REGISTRY)/$${image}:$(SET_TAG)"; \
	done

clean-build:
	rm -f */.Dockerfile.build

clean-containers:
	docker ps -qa | xargs docker rm --force || true

clean-images:
	docker images -qa | xargs docker rmi --force || true

clean-all: clean-build clean-containers clean-images
