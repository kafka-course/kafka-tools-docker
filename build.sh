#!/bin/bash

GIT_COMMIT=$(git rev-parse HEAD)
BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ" | tr -d '\n')
SERVICE_NAME="kafka-tools"
DOCKER_IMAGE_NAME="dancier/${SERVICE_NAME}"
DOCKER_RELEASE_TAG="${DOCKER_IMAGE_NAME}:${GIT_COMMIT}"
DOCKER_LATEST_TAG="${DOCKER_IMAGE_NAME}:latest"


die() {
	echo $1
	exit 1
}

echo "=== ${BUILD_TIME} ==="
docker build \
--build-arg GIT_COMMIT=${GIT_COMMIT} \
--build-arg SERVICE_NAME=${SERVICE_NAME} \
-t "${DOCKER_RELEASE_TAG}" . || die "Failed to build"
docker tag "${DOCKER_RELEASE_TAG}" "${DOCKER_LATEST_TAG}"

echo "docker push ${DOCKER_RELEASE_TAG}"
echo "docker push ${DOCKER_LATEST_TAG}"
