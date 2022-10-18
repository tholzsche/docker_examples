#!/bin/bash -ex

echo "Searching for Docker image ..."
DOCKER_IMAGE_ID=$(docker images --format="{{.ID}}" docker-x11-pulseaudio:latest | head -n 1)
echo "Found and using ${DOCKER_IMAGE_ID}"

USER_UID=$(id -u)

docker run -it --rm \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native \
  -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /run/user/1000/pulse:/run/user/1000/pulse \
  --net=host --dns=8.8.8.8 --env=DISPLAY \
  ${DOCKER_IMAGE_ID} \
  ${@}
