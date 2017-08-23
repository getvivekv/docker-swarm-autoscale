
## Docker Swarm Collector 

This is a simple CPU usage collector tool that will run on each swarm node and send the CPU use of every container to Influx database.
This is a part of docker swarm auto scale project.

### Prerequisites

- Docker Swarm 17.05 or above. (May work with below version as well, but not tested)


### Installation

`docker network create -d overlay swarm-scale`

Note: VOLUME is where the influxdb data will be saved. In the swarm cluster, this should be on a shared drive.

```
VOLUME=/mnt/efs/influxdb
docker network create -d overlay swarm-scale
mkdir ${VOLUME}
docker service create \
    --mount type=bind,source=${VOLUME},target=/var/lib/influxdb,readonly=false \
    --name influxdb \
    --network swarm-scale \
    --constraint "node.role != manager" \
    --detach=true \
    --publish 22050:8086 \    
    influxdb:alpine
```

```
docker service create \
    --name swarm-collector \
    --network swarm-scale \
    --mode global \
    --detach=true \
    --constraint "node.role != manager" \
    --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
    --mount "type=bind,source=/mnt/efs/swarm-scale/collector,target=/app" \
    --mount "type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup" \
    getvivekv/swarm-collector
```        

Note: If you would like to run this on master nodes as well, remove the constraint.

To check the logs 
`docker service logs -f swarm-collector`