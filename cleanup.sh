#!/usr/bin/env bash

set -eux

. vars.sh

sudo docker container kill pbuilder-container || true
sudo docker container rm pbuilder-container || true
sudo docker image rm pbuilder-image -f || true
