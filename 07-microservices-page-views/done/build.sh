#!/bin/bash

docker build -t pageviews-postgres .
docker build -t pageviews-redis .
docker build -t pageviews-webapp .
docker build -t pageviews-nginx .