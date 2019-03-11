#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

docker run --name multi-stage-build-react -p 80:80 -d multi-stage-build-react