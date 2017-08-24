
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
--network swarm-scale \
--name swarm-scale \
--publish 9000:80 \
--mount type=bind,source=/mnt/efs/swarm-scale/scale/src,target=/app,readonly=false \
--mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
--constraint "node.role == manager"  \
getvivekv/swarm-scale
```