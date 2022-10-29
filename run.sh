#!/bin/bash -ex

echo "Searching for Docker image ..."
DOCKER_IMAGE_ID=$(docker images --format="{{.ID}}" docker-x11-vivado:latest | head -n 1)
echo "Found and using ${DOCKER_IMAGE_ID}"

USER_UID=$(id -u)

docker run -it --rm \
  -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  --net=host --dns=8.8.8.8 --env=DISPLAY \
  -v /home/till/Downloads/:/var/tmp \
  ${DOCKER_IMAGE_ID} \
  ${@}
