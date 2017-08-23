#!/bin/bash

chmod +x scripts/*
docker build -t swarm-scale .

docker service rm swarm-scale
docker service create \
	--network swarm-scale \
	--name swarm-scale \
	--publish 9000:80 \
	--mount type=bind,source=/mnt/efs/swarm-scale/scale/src,target=/app,readonly=false \
	--mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
	--constraint "node.role == manager"  \
	--constraint "node.hostname == us-n-m-1.streamone.cloud"  \
	swarm-scale

watch docker service ps swarm-scale
exit ;
docker tag swarm-scale getvivekv/swarm-scale
docker login
docker push getvivekv/swarm-scale

