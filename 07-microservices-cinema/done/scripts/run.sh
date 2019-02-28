#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

docker run --name cinema-traefik -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock cinema-traefik
docker run --name db -d cinema-mongo
docker exec db /backup/restore.sh
docker run --name cinema-bookings --link db:db -d cinema-bookings
docker run --name cinema-showtimes --link db:db -d cinema-showtimes
docker run --name cinema-movies --link db:db -d cinema-movies
docker run --name cinema-users --link db:db -d cinema-users