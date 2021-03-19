#!/bin/bash

BASE_IMAGE_NAME="ghcr.io/krsuhjunho/centos7-base-systemd"
Today=$(date "+%Y-%m-%d")



docker build -t ${BASE_IMAGE_NAME} .

docker push ${BASE_IMAGE_NAME}

git add .
git commit -m "${Today} ghcr.io/krsuhjunho/centos7-base-systemd"
git push origin main
