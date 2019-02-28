#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -aq)
