#!/bin/bash

docker rm -f collector
chmod +x entrypoint.sh
docker build -t collector .

docker service create \
    --name collector \
    --network swarm-scale \
    --constraint "node.hostname == us-n-m-1.streamone.cloud" \
    --detach=true \
    collector

