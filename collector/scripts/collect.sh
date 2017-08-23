#!/bin/sh

# Docker Container Stats Collector
# Author Vivek Vasukuttan <vivekv@vivekv.com>

HOSTNAME=$(curl -s --unix-socket /var/run/docker.sock "http://localhost/info" | jq -r .Name)
docker stats --no-stream --format "{{.ID}} {{.CPUPerc}}" | while read -r line ; do
    CONTAINER_ID=`echo ${line} | cut -d " " -f1`
    CPU=`echo ${line} | cut -d " " -f2 | sed 's/%//'`
    SERVICE_NAME=`docker inspect ${CONTAINER_ID} | jq -r ".[].Config.Labels[\"com.docker.swarm.service.name\"]"`
    curl -i -XPOST 'http://influxdb:8086/write?db=swarm' --data-binary 'cpu_load,service='${SERVICE_NAME}',hostname='${HOSTNAME}',containerid='${CONTAINER_ID}' value='${CPU}
done
