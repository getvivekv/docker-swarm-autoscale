#!/bin/bash

chmod +x scripts/*
docker build -t swarm-scale .

docker tag swarm-scale getvivekv/swarm-scale
docker login
docker push getvivekv/swarm-scale
