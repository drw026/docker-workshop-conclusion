#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

cd $SCRIPT_DIR/postgresql
docker build -t pageviews-postgres .

cd $SCRIPT_DIR/redis
docker build -t pageviews-redis .

cd $SCRIPT_DIR/webapp
docker build -t pageviews-webapp .

cd $SCRIPT_DIR/nginx
docker build -t pageviews-nginx .