#!/bin/bash -ex

echo "Install and execute vnc client ..."
sudo apt install -y vinagre 
vinagre &

echo "Searching for Docker image ..."
DOCKER_IMAGE_ID=$(docker images --format="{{.ID}}" docker-x11-vnc:latest | head -n 1)
echo "Found and using ${DOCKER_IMAGE_ID}"

USER_UID=$(id -u)

docker run --rm --cap-drop=ALL -p 127.0.0.1:5900:5900 \
  -e HOME=/home/noob/ \
  ${DOCKER_IMAGE_ID} \
  x11vnc -forever -create -usepw \
  ${@}
