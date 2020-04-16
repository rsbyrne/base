#!/bin/bash

MOUNTFROM=$PWD
MOUNTTO='/workspace/mount'
IMAGE='rsbyrne/base'
docker run -u 0 -v $MOUNTFROM:$MOUNTTO -it $IMAGE bash

