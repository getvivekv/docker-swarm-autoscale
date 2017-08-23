#!/bin/sh
    curl -s --unix-socket /var/run/docker.sock "http://localhost/containers/json" | jq -r ".[].Id" | while read -r CONTAINER_ID ; do

  CONTAINER_INFO=$(curl -s --unix-socket /var/run/docker.sock "http://localhost/containers/${CONTAINER_ID}/stats?stream=false")

  TOTAL_PRECPU_USAGE=$(echo ${CONTAINER_INFO} | jq -r ".cpu_stats.cpu_usage.total_usage")
  SYSTEM_PRECPU_USAGE=$(echo ${CONTAINER_INFO} | jq -r ".cpu_stats.system_cpu_usage")

sleep 2;

    CONTAINER_INFO=$(curl -s --unix-socket /var/run/docker.sock "http://localhost/containers/${CONTAINER_ID}/stats?stream=false")

#    TOTAL_PRECPU_USAGE=$(echo ${CONTAINER_INFO} | jq -r ".precpu_stats.cpu_usage.total_usage")
#    SYSTEM_PRECPU_USAGE=$(echo ${CONTAINER_INFO} | jq -r ".precpu_stats.system_cpu_usage")

    TOTAL_CPU_USAGE=$(echo ${CONTAINER_INFO} | jq -r ".cpu_stats.cpu_usage.total_usage")
    SYSTEM_CPU_USAGE=$(echo ${CONTAINER_INFO} | jq -r ".cpu_stats.system_cpu_usage")


let "CPU_DELTA = ${TOTAL_CPU_USAGE} - ${TOTAL_PRECPU_USAGE}";
let "SYSTEM_DELTA = ${SYSTEM_CPU_USAGE} - ${SYSTEM_PRECPU_USAGE}"

RESULT=$(echo "$CPU_DELTA/$SYSTEM_DELTA" | bc -l)
RESULT=$(echo "scale=4; $RESULT*100" | bc)

echo ${RESULT}


done

