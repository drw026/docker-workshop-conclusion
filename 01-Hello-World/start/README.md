Hello World
===========

Als eerste gaan we de eerste container draaien, zodat we bekend raken met wat basis docker commando's. Er is een bonus opdracht die laat zien hoe je met docker snel kunt ontwikkelen.

1: Start een nginx container
---------------------------

1. Voer het volgende commando uit

   ```
   docker container run -p 80:80 -d nginx
   ```

Hiermee wordt de image `nginx`, versie `latest` als container gestart. `-p` NAT host poort 80 naar poort 80 van de container. `-d` zorgt ervoor dat de container in daemon mode draait op de achtergrond.

2. Browse naar [http://localhost:80](http://localhost:80).

   ```
   curl localhost
   ```
   
   Of open met een browser `http://<ec2-instance>`.

   Als de continer goed opgestart is dan zie je de `Welcome to nginx!` pagina.

3. Zie de huidig draaiende container.

   ```
   docker container list
   ```
4. Voer het volgende commando uit.

   ``` 
   docker image list
   ```

De Nginx image staat in de lijst.

5. Stop de container met het volgende commando:

   ```
   docker container stop ... 
   ```
   Vervang `...` met de `CONTAINER ID` uit stap 2

6. Image

   ```
   docker image list
   ```
   De image bestaat nog steeds. De container die we gemaakt hebben op basis van de image is weg.

Bonusopdracht
=============

Het Volume stuk komt later uitgebreid aan bod, maar in de bonus opdracht gaan we alvast laten zien hoe je een volume kan gebruiken om snel te ontwikkelen. Met volumes kun je namelijk sneller ontwikkelen, omdat je een volume van je systeem koppelt met je container. Wanneer je dan een bestand aanpast en opslaat kun het resultaat direct bekijken zonder dat je de container moet rebuilden.

Draai een prebuild nginx container
----------------------------------

1. `docker pull nginx:alpine`  wil je meer weten over deze image [Docker Hub](https://hub.docker.com/_/nginx/) en [Dockerfile](https://github.com/nginxinc/docker-nginx/blob/590f9ba27d6d11da346440682891bee6694245f5/mainline/alpine/Dockerfile) om te zien hoe die gemaakt is.

2. Maak een directory in de start directory aan bijvoorbeeld `src`. 

3. `docker run -v /pad/naar/start/src:/usr/share/nginx/html -p 8080:80 -d nginx:alpine` vervang `/pad/naar/start/src` met de directory uit stap 2.

Voorbeeld: als je in stap 2 `/home/ec2-user/docker-workshop/01-Hello-World/start/src` hebt aangemaakt, dan start je de container als volgt 

`docker run -v ~/docker-workshop/01-Hello-World/start/src:/usr/share/nginx/html -p 8080:80 -d nginx:alpine`.

Hiermee wordt een container opgestart op basis van de nginx alpine image met een mapping van `~/docker-workshop/01-Hello-World/start/src` naar `/usr/share/nginx/html` in de container. Poort `8080` wordt geNAT van buiten de container naar poort `80` van de container. 

4. Browse naar [http://localhost:8080](http://localhost:8080).

   ```
   curl localhost:8080
   ```
   
   Of open met een browser `http://<ec2-instance>`.
   
   In plaats van de welkomst text van nginx krijg je nu een status 404 of status 403, omdat de webserver nog geen bestanden heeft om te serveren.

Edit files
----------

1. Maak een bestaand aan.  bijvoorbeeld `index.html` of `hello.html`.

2. Browse naar de url -- [http://localhost:8080/hello.html](http://localhost:8080/hello.html).

   Of open met een browser `http://<ec2-instance>:8080/hello.html`.

   Nginx eerst kijken of er een index.html is. Als die er niet is krijg je een HTTP status 403. Browse in dat geval direct naar het bestand wat je hebt aangemaakt.
   
3. Wijzig de bestanden.

4. Browse browse naar de url(s).

Door middel van het volume kun je snel ontwikkelen zonder dat je de container opnieuw hoeft te rebuilden. Dit is ideaal voor een development omgeving.
Voor een productie omgeving zou dit niet werken, want dan zou je lege image hebben.

Laten we dit oplossen!

Maak een Dockerfile
-------------------

1. Vanuit de src directory. Maak een bestand aan `Dockerfile-prod`. Voeg de volgende regels toe:

   ```
   FROM nginx:alpine
   COPY . /usr/share/nginx/html
   ```

2. Build de Dockerfile naar image:

   ```
   docker build -t nginxprod:0.1 -f Dockerfile-prod .
   ```

3. Stop oude container zoals je eerder gedaan hebt bij 1: Start een nginx container -- stap 5.

3. Start de image als container:

   ```
   docker run -p 8080:80 -d nginxprod:0.1
   ```

4. Browse naar de url -- [http://localhost:8080/hello.html](http://localhost:8080/hello.html).

    Of open met een browser `http://<ec2-instance>:8080/hello.html`.

We hebben nu twee docker images -- een voor development waar we de nginx alpine gebruiken en een volume koppelen en een voor productie die je zelf build.
