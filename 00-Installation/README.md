Installatie Docker Community Edition
====================================

Installatie Docker CE on AWS EC2
--------------------------------

### Linux

Volg de installing docker instructies.

- [https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker)


Controle
--------

Vanaf de command-line:

`docker --version`

`docker run hello-world`

Als beide werken dan is je docker omgeving correct opgezet.


Start downloading docker images
-------------------------------

Downloading docker images takes a while, so let's kick this off so we make sure they exist when we need them:

1. `docker pull nginx`
2. `docker pull node:alpine`