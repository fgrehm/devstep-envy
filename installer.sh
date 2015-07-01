#!/bin/bash

set -e

if [[ -z "${1}" ]]; then
  echo 'You need to provide the SSH port you want to expose'
  echo 'as an argument to the installer'
  exit 1
fi

SSH_PORT="${1}"
HOST_DATA="${2:-/var/data/devstep-envy}"

docker run -d --name devstep-envy \
  --restart="always" \
  -v $HOST_DATA:/data \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -p 80:80 \
  -p ${SSH_PORT}:22 \
  -e HOST_DATA \
  fgrehm/devstep-envy

docker pull fgrehm/devstep-envy-project
docker pull jpetazzo/dind
