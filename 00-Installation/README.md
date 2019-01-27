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

**Windows only:** If you're preparing for the conference from your hotel room or you're following this tutorial online, switch to Windows Containers by right-clicking the Docker icon in the system tray and choose "Switch to Windows Containers", then download these additional containers:

**If you're in the room, don't download these windows containers as we'll kill the conference wifi**

1. `docker pull microsoft/nanoserver:1803`
2. `docker pull stefanscherer/node-windows`
3. `docker pull microsoft/dotnet:2.1-aspnetcore-runtime`
4. `docker pull microsoft/dotnet:2.1-sdk`
5. Switch back to Linux containers -- we'll begin with Linux workloads

![Switch to Windows Containers](switch-to-windows.png)


Help your neighbor
------------------

There's someone sitting next to you whose struggling with this.  Let's pair and help each other.  When that machine is running, let's all celebrate and join another team.  At the end, we'll celebrate around the last machine.
