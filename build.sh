#!/bin/bash -ex

docker build --tag 'docker-x11-pulseaudio:latest' -f dockerfile .
