Installatie Docker Community Edition
====================================

Installatie Docker CE on AWS EC2
--------------------------------

### Linux

Docker en docker compose zijn pre-installed op de ec2-instances.

Controle
--------

Vanaf de command-line:

```bash
docker --version
Docker version 18.06.1-ce, build e68fc7a215d7133c34aa18e3b72b4a21fd0c6136

```

Als beide werken dan is je docker omgeving correct opgezet.

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