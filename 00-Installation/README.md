Installatie Docker Community Edition
====================================

Installatie Docker CE on AWS EC2
--------------------------------

### Linux

Volg de instructies op docs.docker.com.

- Other: [https://docs.docker.com/engine/installation/linux/docker-ce/binaries/](https://docs.docker.com/engine/installation/linux/docker-ce/binaries/)


Controle
--------

Vanaf de command-line:

`docker --version`

`docker run hello-world`

Als beide werken dan is je docker omgeving correct opgezet.


Start downloading docker images
-------------------------------

Downloading docker images takes a while, so let's kick this off so we make sure they exist when we need them:

1. `docker pull nginx:alpine`
2. `docker pull node:alpine`