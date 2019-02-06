

Docker Workshop
===============

Welkom bij de Docker workshop.

TODO
=========
- Automatiseren aanmaken van omgevingen op AWS
    - Omgevingen opzetten voor deelnemers
    - Documenteren hoe deelnemers kunnen verbinden met hun omgeving
- 00-Installatie
    DONE - Documentatie voor het installeren van Docker CE
    - Eventueel installatie van awscli (eventueel vooraf al installeren)
- 01-Hello-World
    DONE - Eerste container (docker pull nginx, docker run)
    DONE - Controle van het resultaat, zodat de deelnemers beter bekend raken met de docker commando's
    DONE - Documentatie voor de deelnemers
- 02-Hello-Docker
    DONE - Maken van een node app met een Docker file
    DONE - Source code https://nodejs.org/en/about/
    DONE - build van de app en run van de app
    DONE - Aanpassen source code, zodat de container "Hello World" output
    DONE - Build van de nieuwe app
    DONE - Stop de oude app en run de nieuwe app
03-multi-stage-build
    DONE - Maken van een react applicatie middels een multi-stage build
    - Documentatie over de react app
04-multi-stage-build-2
    - Maken van een dotnet core multi-stage build app
    - Documentatie over de app


Het doel van deze sessie
---------
Het doel van deze sessie is om bekend te raken met Docker en het maken van Docker containers.


Voorwaarden
-------------

Je kunt SSH'en naar vooraf opgezette AWS EC2 instance.
Maak een clone van deze repository op de EC2 instance of je computer.

Alternatief
-----------

Je kunt de repository clonen naar de laptop en de code met SCP of WinSCP uploaden naar je EC2 instance.

Artikels
--------

- http://training.play-with-docker.com/
- http://labs.play-with-docker.com/
- https://katacoda.com/
- https://docs.docker.com/learn/
- https://docs.docker.com/engine/tutorials/
