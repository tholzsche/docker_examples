#!/bin/bash -ex

docker build --tag 'docker-x11-vnc:latest' -f dockerfile .
