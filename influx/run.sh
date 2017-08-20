#!/bin/bash

# Location where the data will be saved. This needs to be a shared drive
VOLUME=/mnt/efs/influxdb

docker network create -d overlay swarm-scale
mkdir ${VOLUME}
docker service create \
    --mount type=bind,source=${VOLUME},target=/var/lib/influxdb,readonly=false \
    --name influxdb \
    --network swarm-scale \
    --detach=true \
    influxdb:alpine