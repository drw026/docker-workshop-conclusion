Installing Docker Community Edition
===================================

Install Docker CE on AWS EC2
-----------------------------

### Linux

Follow the instructions on docs.docker.com for your OS:

- Other: [https://docs.docker.com/engine/installation/linux/docker-ce/binaries/](https://docs.docker.com/engine/installation/linux/docker-ce/binaries/)


Verify it Works
---------------

From a command prompt / terminal, type:

`docker --version`

then type

`docker run hello-world`

If both of these work as expected, you've succeeded!


Start downloading docker images
-------------------------------

Downloading docker images takes a while, so let's kick this off so we make sure they exist when we need them:

1. `docker pull nginx:alpine`
2. `docker pull node:alpine`
3. `docker pull microsoft/dotnet:2.1-aspnetcore-runtime-alpine`
4. `docker pull microsoft/dotnet:2.1-sdk-alpine`


Help your neighbor
------------------

There's someone sitting next to you whose struggling with this.  Let's pair and help each other.  When that machine is running, let's all celebrate and join another team.  At the end, we'll celebrate around the last machine.
