#!/bin/bash

#VAR
DOCKER_CONTAINER_NAME="centos7-base-systemd"
CONTAINER_HOST_NAME="centos7-base-systemd"
SSH_PORT=22455
HTTP_PORT=8010
BASE_IMAGE_NAME="ghcr.io/krsuhjunho/centos7-base-systemd"
TIME_ZONE="Asia/Tokyo"
TODAY=$(date "+%Y-%m-%d")
COMMIT_COMMENT="$2"
BUILD_OPTION="$1"

DOCKER_IMAGE_BUILD()
{
docker build -t ${BASE_IMAGE_NAME} .
}

DOCKER_IMAGE_PUSH()
{
docker push ${BASE_IMAGE_NAME}
}

GIT_COMMIT_PUSH()
{
git add . --ignore-removal
git commit -m "${TODAY} ${COMMIT_COMMENT}"
git config credential.helper store
git push origin main
}

DOCKER_CONTAINER_REMOVE()
{
docker rm -f ${DOCKER_CONTAINER_NAME}
}

DOCKER_CONTAINER_CREATE()
{
docker run -tid --privileged=true \
-h "${CONTAINER_HOST_NAME}" \
--name="${DOCKER_CONTAINER_NAME}" \
-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v /etc/localtime:/etc/localtime:ro \
-e TZ=${TIME_ZONE} \
-p ${SSH_PORT}:22 -p ${HTTP_PORT}:80 \
${BASE_IMAGE_NAME}
}

DOCKER_CONTAINER_BASH()
{
docker exec -it ${DOCKER_CONTAINER_NAME} /bin/bash
}

DOCKER_CONTAINER_URL_SHOW()
{
echo ""
echo "Centos7 Base Systemd Image"
echo ""
}

MAIN()
{

if [ "$BUILD_OPTION" == "--build" ]; then
    DOCKER_IMAGE_BUILD
	DOCKER_IMAGE_PUSH
	GIT_COMMIT_PUSH
fi

DOCKER_CONTAINER_REMOVE
DOCKER_CONTAINER_CREATE
#DOCKER_CONTAINER_BASH
DOCKER_CONTAINER_URL_SHOW
}

MAIN