
## Docker Swarm Collector 

This is a simple CPU usage collector tool that will run on each swarm node and send the CPU use of every container to Influx database.
This is a part of docker swarm auto scale project.

### Installation

`docker network create -d overlay swarm-scale`

`docker service create \
    --name swarm-collector \
    --network swarm-scale \
    --mode global \
    --detach=true \
    --constraint "node.role != manager" \
    --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
    getvivekv/swarm-collector`

Note: If you would like to run this on master nodes as well, remove the constraint.

To check the logs 
`docker service logs -f swarm-collector`