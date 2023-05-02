export FULL_VERSION_RELEASE="$$(cat ./VERSION)"
export FULL_VERSION="$$(cat ./VERSION)"
export DOCKER_REPO="etzion/dnsexit"
export CBRANCH=$$(git rev-parse --abbrev-ref HEAD | tr / -)

FULL_VERSION_RELEASE = $(shell cat ./VERSION)
GET_ALPINE = $(docker image pull alpine:latest)
GET_ALP_VERSION = $(shell docker run --rm alpine:latest grep ^VERSION /etc/os-release | cut -f 2 -d = )
GET_VERSION = $(eval VERSION=$(FULL_VERSION_RELEASE)_ALP$(GET_ALP_VERSION))


.PHONY: build

all: build

build:	
	@echo "Making production version ${FULL_VERSION} of DockOvpn"
	$(GET_ALPINE)
	$(GET_VERSION)
	@echo $(VERSION)
	
	docker build -t "${DOCKER_REPO}:$(VERSION)" -t "${DOCKER_REPO}:latest" . --no-cache
	docker push "${DOCKER_REPO}:$(VERSION)"
	docker push "${DOCKER_REPO}:latest"
