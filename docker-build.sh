#!/bin/bash

BASE_IMAGE_NAME="ghcr.io/krsuhjunho/centos7-base-systemd"
Today=$(date "+%Y-%m-%d")
Comment="$1"


docker build -t ${BASE_IMAGE_NAME} .

docker push ${BASE_IMAGE_NAME}

git add .
git commit -m "${Today} ${Comment}"
git push origin main
