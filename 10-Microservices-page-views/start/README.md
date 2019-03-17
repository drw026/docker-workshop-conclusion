Microservices - Page Views
==========================

In deze opdracht gaan we een mircoservices applicatie maken die bij houdt hoe vaak de webpagina bezocht is.
De applicatie bestaat uit vier onderdelen:
    - [PostgreSQL](https://www.postgresql.org/)
    - [Redis](https://redis.io/)
    - [Flask](http://flask.pocoo.org/)
    - [NGINX](https://www.nginx.com/)

**Tip:** Je kunt jouw werkt controleren met wat in de `done` map staat.

1: NGINX
--------

1. Ga naar de pageviews-nginx directory en review de `Dockerfile`.

2. Maak een NGINX webserver container aan de hand van de volgende voorwaarden:
    - Vul de `Dockerfile` aan voor de NGINX websever.  
    - Zorg dat de `src/nginx.conf` gekopieerd wordt in de container. 
    - NGINX moet beschikbaar zijn op poort 80.

3. Build de NGINX container.
    - Tag de de container met `pageviews-nginx`.

4. Als de build klaar is controleer dat je image aanwezig is.


2: PostgreSQL
-------------

**Image:** [postgresql](https://hub.docker.com/_/postgres)

1. Ga naar de pageviews-postgresql directory en review de `Dockerfile`.

2. Maak een PostgreSQL database container:
    - Vul de `Dockerfile` aan voor de PostgreSQL database server.
    - Maak de volgende environment(ENV) variabelen aan:
        - POSTGRES_USER=postgres
        - POSTGRES_PASSWORD=dbPageViews
        - POSTGRES_DB=dbPageViews
    - Zorg dat de `src/init.sh` gekopieerd wordt in de contianer naar `/docker-entrypoint-initdb.d`
    - PostgreSQL moet beschikbaar zijn op poort 5432.

3. Build de PostgreSQL container.
    - Tag de de container met `pageviews-postgres`.

4. Als de build klaar is, controleer dat je image aanwezig is.

3: Redis
--------

**Image:** [redis](https://hub.docker.com/_/redis)

1. Ga naar de pageviews-redis directory en review de `Dockerfile`.

2. Maak een `Dockerfile` voor Redis.
    - Vul de `Dockerfile` aan voor de redis server.
    - Er zijn geen instellingen die gewijzigd hoeven te worden.

3. Build de Redis container.
    - Tag de de container met `pageviews-redis`.

4. Als de build klaar is controleer dat je image aanwezig is.

4: Webapp
---------

1. Ga naar de pageviews-webapp directory en review de `Dockerfile`.

1. Voeg aan de `Dockerfile` van de webapp het volgende toe:
    - Kopieer de `src` directory in de container naar `/home/flask/app/web`.
    - De webapp moet beschikbaar zijn op poort 8000.

2. Build de webapp container.
    - Tag de de container met `pageviews-webapp`.

3. Als de build klaar is controleer dat je image aanwezig is.


5: Start de containers
----------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 6.

1. Vanaf de command-line voer je het volgende uit:

    - PostgreSQL
    ```
    docker run --name pageviews-postgres -d pageviews-postgres 
    ```

    - Redis
   ```
   docker run --name pageviews-redis -d pageviews-redis
   ```

    - webapp
   ```
   docker run --name pageviews-webapp --link pageviews-postgres:postgres --link pageviews-redis:redis -d pageviews-webapp
   ```
   Met de flag `--link` maken we een verbinding mogelijk naar de postgres container en de redis container.

    **Bron:** https://docs.docker.com/network/links/#communication-across-links


    - nginx
    ```
   docker run --name pageviews-nginx --link pageviews-webapp -p 80:80 -d pageviews-nginx
   ```

2. Open met je browser [http://ec2-instance](http://ec2-instance).

3. Controleer de huidig draaiende containers.

   ```
   docker container list
   ```


6: Debugging container
----------------------

Is je container niet goed opgestart? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

    Let op `CONTAINER ID` en `NAMES` van een failed container. Die hebben we bij de volgende stap nodig.

2. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` met een container uit de vorige stap. 

    Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is.

7: Stop en verwijder de containers
----------------------------------

Je kunt alle containers in een commando stoppen door het volgende te doen.
Ga naar de `done` directory en maak gebruik van het `make` commando `make cleanup`.

Of

```
docker container stop $(docker container list -aq)
docker container rm $(docker container list -aq)
```
Of
```
docker container rm -f $(docker container list -aq)
```
Of stop de containers per container.

1. `docker container list` -- Let op `CONTAINER ID` en `NAMES` van de running container.

2. `docker container stop ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee stop je de container.

3. `docker container list` -- Zie dat de container nu stopped is.

4. `docker container list --all` -- Zie alle container beide gestop en gestart.

5. `docker container rm ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee verwijder je de container.

6. `docker image list`.  -- De image bestaat nog steeds. De container die we gemaakt hebben op basis van de image is weg.

