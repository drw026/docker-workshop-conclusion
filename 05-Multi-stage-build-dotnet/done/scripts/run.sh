#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

docker run --name multi-stage-build-dotnet -p 5000:5000 -d multi-stage-build-dotnet