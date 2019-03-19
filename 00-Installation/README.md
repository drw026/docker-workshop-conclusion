Installatie Docker Community Edition
====================================

Installatie Docker CE on AWS EC2
--------------------------------

### Linux

Volg de installing docker instructies via de volgende link:

- [https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker)


Controle
--------

Vanaf de command-line:

`docker --version`

`docker run hello-world`

Als beide werken dan is je docker omgeving correct opgezet.

Installatie Docker Compose
--------------------------

Volg de Install Compose on Linux systems via de volgende link:

- [https://docs.docker.com/compose/install/] (https://docs.docker.com/compose/install/)


Start downloaden docker images
-------------------------------

Het downloaden van docker images neemt wat tijd in beslag, dus start met downloaden, zodat deze beschikbaar zijn zodra je ze nodig hebt:

1. `docker pull nginx`
2. `docker pull node:alpine`
3. `docker pull microsoft/dotnet:2.1-aspnetcore-runtime-alpine`
4. `docker pull microsoft/dotnet:2.1-sdk-alpine`
5. `docker pull php:7.3-apache`
6. `docker pull php:7.3-alpine`
7. `docker pull golang:1.11.2`
8. `docker pull mongo`
9. `docker pull traefik:alpine`
10. `docker pull postgres`
11. `docker pull redis:alpine`
12. `docker pull python:3.6.2-slim`

Note: er is een 00-Installation/scripts/docker-pull.sh script