#!/bin/bash

sudo docker build -t vslam_env .

echo Build container

# -d    background running
# -it   inveractive terminal
# --net=host    sharing network from base OS
# --volume  share host's xserver with a container
# --privileged real root
docker run \
        -d  \
        -it \
        --name vslam_runner \
        --mount type=bind,source="$HOME"/workspace,target=/root/workspace \
        --net=host \
        --env=DISPLAY   \
        --volume=$HOME/.Xauthority:/root/.Xauthority \
        --volume="/dev:/dev" \
        --privileged    \
        vslam_env


