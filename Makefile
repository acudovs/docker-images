IMAGES = \
	centos7-systemd \
	centos7-build

REGISTRY = docker.io/alekseychudov
TAG = staging
SET_TAG = staging
UMASK = 0022

.PHONY: $(IMAGES) images pull push tag clean-all clean-build clean-containers clean-images

images:
	umask $(UMASK); \
	for image in $(IMAGES); do \
		sed 's|$$(REGISTRY)|$(REGISTRY)|g; s|$$(TAG)|$(TAG)|g' "$${image}/Dockerfile" > "$${image}/.Dockerfile.build"; \
		docker build --force-rm --no-cache -t "$(REGISTRY)/$${image}:$(SET_TAG)" -f "$${image}/.Dockerfile.build" "$${image}"; \
	done

pull:
	for image in $(IMAGES); do \
		docker pull "$(REGISTRY)/$${image}:$(TAG)"; \
	done

push:
	for image in $(IMAGES); do \
		docker push "$(REGISTRY)/$${image}:$(TAG)"; \
	done

tag: pull
	for image in $(IMAGES); do \
		docker tag "$(REGISTRY)/$${image}:$(TAG)" "$(REGISTRY)/$${image}:$(SET_TAG)"; \
	done

clean-build:
	rm -f */.Dockerfile.build

clean-containers:
	docker ps -qa | xargs docker rm --force || true

clean-images:
	docker images -qa | xargs docker rmi --force || true

clean-all: clean-build clean-containers clean-images
