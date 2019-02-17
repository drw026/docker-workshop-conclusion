Microservices - Page views
==========================


1: NGINX
--------

1. Maak een nieuw bestand in de nginx directory en noem het Dockerfile.

2. Voeg de volgende regel toe:

   ```
   FROM nginx:alpine
   ```

3. Voeg de volgende regel toe:

   ```
   COPY src/nginx.conf /etc/nginx/nginx.conf
   ```

   Deze regel kopieert de `nginx.conf` vanuit de `src` naar `/etc/nginx/nginx.conf` in de image.

4. Volgende regel:

   ```
   EXPOSE 80
   ```

   Deze regel opent poort 80 voor verkeer van buitenaf.

5. Sla de Dockerfile op

6. Vanuit de `nginx` directory, voer je het volgende commando uit. 

   ```
   docker build --tag pageviews-nginx .
   ```
   
Hiermee maak je een image op basis van de Dockerfile en tag je image met de naam `pageviews-nginx`.

7. Als de build klaar is voer dan het volgende uit.

   ```
   docker image list
   ```
   
Jouw image staat bovenaan de lijst.

X: PostgreSQL
-------------


X: redis
--------


X: webapp
---------


X: start de containers
----------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 5.

1. Vanaf de command-line voer je het volgende uit.

   ```
   docker run --name pageviews-postgres -d pageviews-postgres 
   docker run --name pageviews-redis -d pageviews-redis
   docker run --name pageviews-webapp --link pageviews-postgres:postgres --link pageviews-redis:redis -d pageviews-webapp
   docker run --name pageviews-nginx --link pageviews-webapp -p 80:80 -d pageviews-nginx
   ```

2. Roep met curl de url aan [http://localhost](http://localhost).  Success!
   
   ```
   curl http://localhost
   curl localhost/resetcounter
   ```

3. Controleer de huidig draaiende containers.

   ```
   docker container list
   ```

   Draait je container niet? Zie deel X.


X: Debugging container
----------------------

Is je container niet goed opgestart? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

2. Let op `CONTAINER ID` en `NAMES` van failed container.  Die hebben we bij de volgende stap nodig.

3. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is?

4. Verwijder de container met het stop commando uit deel 6. Ga dan terug naar deel 3 en rebuild de image en run de container opnieuw.

5. Start de container met `docker run IMAGE` zonder `-d` de console output komt direct op je scherm.

6. Als je genoeg gezien hebt, gebruik dan CNTRL-C om terug te gaan naar je host's terminal.


X: Stop en verwijder de containers
---------------------------------

Je kunt alle containers in een commando stoppen door het volgende te doen.

```
docker container stop $(docker container list -aq)
docker container rm $(docker container list -aq)
```
Of
```
docker container rm -f $(docker container list -aq)
```

Anders stop je de containers per container.

1. `docker container list` -- Let op `CONTAINER ID` en `NAMES` van de running container.

2. `docker container stop ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee stop je de container.

3. `docker container list` -- Zie dat de container nu stopped is.

4. `docker container list --all` -- Zie alle container beide gestop en gestart.

5. `docker container rm ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee verwijder je de container.

6. `docker image list`.  -- De image bestaat nog steeds. De container die we gemaakt hebben op basis van de image is weg.