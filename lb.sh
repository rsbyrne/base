#!/bin/bash

MOUNTFROM=$PWD
MOUNTTO='/workspace/mount'
IMAGE='rsbyrne/base'
docker run -u 0 -v $MOUNTFROM:$MOUNTTO -p 8888:8888 $IMAGE \
  jupyter lab --no-browser --allow-root --port=8888 --ip='0.0.0.0'

