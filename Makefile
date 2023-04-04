export FULL_VERSION_RELEASE="$$(cat ./VERSION)"
export FULL_VERSION="$$(cat ./VERSION)"
export DOCKER_REPO="etzion/dnsexit"
export CBRANCH=$$(git rev-parse --abbrev-ref HEAD | tr / -)

.PHONY: build

all: build

build:
	@echo "Making production version ${FULL_VERSION} of DockOvpn"
	docker build -t "${DOCKER_REPO}:${FULL_VERSION}" -t "${DOCKER_REPO}:latest" . --no-cache
	docker push "${DOCKER_REPO}:${FULL_VERSION}"
	docker push "${DOCKER_REPO}:latest"
