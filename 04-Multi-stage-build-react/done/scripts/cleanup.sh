#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

RMI=false

if [ $RMI == true ]; then
    docker rm -f $(docker ps -aq)
    docker rmi -f $(docker images -aq)
else
    docker rm -f $(docker ps -aq)
fi
