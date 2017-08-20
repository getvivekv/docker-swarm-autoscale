#!/bin/sh
curl -XPOST http://influxdb:8086/query --data-urlencode "q=CREATE DATABASE swarm"

/bin/watch -n 30 /bin/sh collect.sh
