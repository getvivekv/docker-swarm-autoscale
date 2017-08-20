#!/bin/bash

chmod +x scripts/*
docker build -t swarm-collector .
docker tag swarm-collector getvivekv/swarm-collector
docker login
docker push getvivekv/swarm-collector
