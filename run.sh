#!/usr/bin/env bash

. vars.sh

sudo docker build -t pbuilder-image .
sudo docker run --privileged -dit --name pbuilder-container pbuilder-image
sudo docker exec -it pbuilder-container /bin/setup-pbuilder.sh
sudo docker exec -it pbuilder-container /bin/hyprwayland-scanner.sh
