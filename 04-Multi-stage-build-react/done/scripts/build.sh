#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

for i in `ls -l ../ | grep '^d' | grep -v scripts |awk '{ print $9 }'`; do
    cd ../$i
    docker build -t multi-stage-build-react .
done