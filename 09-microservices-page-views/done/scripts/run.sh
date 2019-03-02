#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

docker run --name pageviews-postgres -d pageviews-postgresql
docker run --name pageviews-redis -d pageviews-redis
docker run --name pageviews-webapp --link pageviews-postgres:postgres --link pageviews-redis:redis -d pageviews-webapp
docker run --name pageviews-nginx --link pageviews-webapp -p 80:80 -d pageviews-nginx