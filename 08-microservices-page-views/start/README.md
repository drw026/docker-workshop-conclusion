Microservices - Page Views
==========================

In deze opdracht gaan we een mircoservices applicatie maken die bij houdt hoe vaak de webpagina bezocht is.
De applicatie bestaat uit vier onderdelen
    - [PostgreSQL](https://www.postgresql.org/)
    - [Redis](https://redis.io/)
    - [Flask](http://flask.pocoo.org/)
    - [NGINX](https://www.nginx.com/)

**Tip:** Je kunt jouw werkt controleren met wat in de done map staat.

1: NGINX
--------

1. Maak een NGINX webserver container aan de hand van de volgende voorwaarden.
    - Maak een Dockerfile voor de NGINX websever.  
    - Zorg dat de `src/nginx.conf` gekopieerd wordt in de container. 
    - NGINX moet beschikbaar zijn op poort 80

2. Build de NGINX container
    - Tag de de container met pageviews-nginx

3. Als de build klaar is controleer dat je image aanwezig is.


2: PostgreSQL
-------------

1. Maak een PostgreSQL database container
    - Maak een Dockerfile voor de PostgreSQL database server
    - Maak de volgende environment(ENV) variablen aan:
        - POSTGRES_USER=postgres
        - POSTGRES_PASSWORD=dbPageViews
        - POSTGRES_DB=dbPageViews
    - Zorg dat de `src/init.sh` gekopieerd wordt in de contianer naar `/docker-entrypoint-initdb.d`
    - PostgreSQL moet beschikbaar zijn op poort 5432

2. Build de PostgreSQL container
    - Tag de de container met pageviews-postgres

3. Als de build klaar is, controleer dat je image aanwezig is.


3: Redis
--------

1. Maak een Dockerfile voor Redis
    - Er zijn geen instellingen die gewijzigd hoeven te worden.

2. Build de Redis container
    - Tag de de container met pageviews-redis

3. Als de build klaar is controleer dat je image aanwezig is.



4: Webapp
---------

1. Voeg aan de Dockerfile van de webapp het volgende toe:
    - Kopieer de `src` directory in de container naar `/home/flask/app/web`
    - De webapp moet beschikbaar zijn op poort 8000

2. Build de webapp container
    - Tag de de container met pageviews-webapp

3. Als de build klaar is controleer dat je image aanwezig is.


5: Start de containers
----------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 6.

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


6: Debugging container
----------------------

Is je container niet goed opgestart? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

2. Let op `CONTAINER ID` en `NAMES` van failed container.  Die hebben we bij de volgende stap nodig.

3. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is?

4. Verwijder de container met het stop commando uit deel 6. Ga dan terug naar deel 3 en rebuild de image en run de container opnieuw.

5. Start de container met `docker run IMAGE` zonder `-d` de console output komt direct op je scherm.

6. Als je genoeg gezien hebt, gebruik dan CNTRL-C om terug te gaan naar je host's terminal.


7: Stop en verwijder de containers
----------------------------------

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


***TIP:*** In de `done` directory staat een `Makefile` deze heeft een aantal funties onder andere een cleanup. Deze kun je uitvoeren door `make cleanup` uit te voeren.
