#!/bin/bash

# This should be enabled but unfortunately docker-machine ssh does not show the
# output when something goes wrong
# set -e

if [[ -z "${1}" ]]; then
  echo 'You need to provide the SSH port you want to expose'
  echo 'as an argument to the installer'
  # This should be != 0 but unfortunately docker-machine ssh does not show the
  # output when something goes wrong
  exit 0
fi

SSH_PORT="${1}"
HOST_ROOT="${2:-/mnt/devstep-envy}"

docker run -d -t --name devstep-envy \
  --restart="always" \
  -v $HOST_ROOT:/envy \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -p 80:80 \
  -p ${SSH_PORT}:22 \
  -e HOST_ROOT="${HOST_ROOT}" \
  fgrehm/devstep-envy

docker pull fgrehm/devstep-envy-project
docker pull jpetazzo/dind

# Exit zero regardless of other errors that might have occured
# docker-machine ssh does not show the output when something
# goes wrong
exit 0
