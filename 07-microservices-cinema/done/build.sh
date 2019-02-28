#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}

cd $SCRIPT_DIR/traefik
docker build -t cinema-traefik .

cd $SCRIPT_DIR/mongo
docker build -t cinema-mongo .

cd $SCRIPT_DIR/bookings
docker build -t cinema-bookings .

cd $SCRIPT_DIR/movies
docker build -t cinema-movies .

cd $SCRIPT_DIR/showtimes
docker build -t cinema-showtimes .

cd $SCRIPT_DIR/users
docker build -t cinema-users .