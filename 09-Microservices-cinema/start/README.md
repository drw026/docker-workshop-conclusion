Microservices - Cinema app
==========================

In deze opdracht gaan we een mircoservices applicatie voor een Bioscoop(Cinema) maken. 

Deze applicatie bestaat uit een aantal API's.
    - [Traefik](https://traefik.io/)
    - [Mongo](https://www.mongodb.com/)
    - API - bookings
    - API - movies
    - API - showtimes
    - API - users

**Tip:** Je kunt jouw werkt controleren met wat in de done map staat.

0: Prerequisites
----------------

Voeg achter eerste regel in de `/etc/hosts` van je ec2 instance het volgende toe. 

`movies.local bookings.local users.local showtimes.local monitor.local`


1: Traefik
----------

1. Maak een Traefik loadbalancer container aan de hand van de volgende voorwaarden:
    - Maak een Dockerfile voor de Traefik loadbalancer.
    - Gebruik de alpine versie voor de image. 
    - Zorg dat de `src/traefik.toml` gekopieerd wordt in de container naar `/etc/traefik/traefik.toml`. 
    - Traefik moet beschikbaar zijn op poort 80.
    - Traefik dashboard moet beschikbaar zijn op poort 8080.

2. Build de traefik container:
    - Tag de de container met cinema-traefik.

3. Als de build klaar is controleer dat je image aanwezig is.

4. Start de Traefik loadbalancer.

2: MongoDB
----------

1. Ga naar de cinema-mongo directory en review de `Dockerfile`.

2. Build de MongoDB container.
    - Tag de de container met cinema-mongo.

3. Als de build klaar is, controleer dat de image aanwezig is.

3: API - bookings
-----------------

1. Ga naar de cinema-booking directory en review de `Dockerfile`.

2. Pas de Dockerfile aan voor de bookings API en voeg de volgende labels toe:
   `LABEL traefik.backend=bookings`
   `LABEL traefik.frontend.rule=Host:bookings.local`

Met de labels geven we aan hoe de API toevoegd wordt aan de loadbalancer. De traefik frontend luistert op `bookings.local` en koppelt dit met de bookings container als backend.

3. Build de bookings container.
    - Tag de de container met cinema-bookings.

4. Als de build klaar is controleer dat de image aanwezig is.


4: API - movies
---------------

1. Ga naar de cinema-movies directory en review de `Dockerfile`.

2. Pas de Dockerfile aan voor de movies API en voeg de volgende labels toe:
   `LABEL traefik.backend=movies`
   `LABEL traefik.frontend.rule=Host:movies.local`

Met de labels geven we aan hoe de API toevoegd aan de loadbalancer. De traefik frontend luistert op `movies.local` en koppelt dit met de movies container als backend.

3. Build de movies container.
    - Tag de de container met cinema-movies.

4. Als de build klaar is controleer dat de image aanwezig is.


5: API - showtimes
------------------

1. Ga naar de cinema-showtimes directory en review de `Dockerfile`.

2. Pas de Dockerfile aan voor de showtimes API en voeg de volgende labels toe:
   `LABEL traefik.backend=showtimes`
   `LABEL traefik.frontend.rule=Host:showtimes.local`

Met de labels geven we aan hoe de API toevoegd aan de loadbalancer. De traefik frontend luistert op `showtimes.local` en koppelt dit met de showtimes container als backend.

3. Build de showtimes container.
    - Tag de de container met cinema-showtimes.

4. Als de build klaar is controleer dat de image aanwezig is.


6: API - users
--------------

1. Ga naar de cinema-users directory en review de `Dockerfile`.

2. Pas de Dockerfile aan voor de users API en voeg de volgende labels toe:
   `LABEL traefik.backend=users`
   `LABEL traefik.frontend.rule=Host:users.local`

Met de labels geven we aan hoe de API toevoegd aan de loadbalancer. De traefik frontend luistert op `users.local` en koppelt dit met de users container als backend.   

3. Build de users container.
    - Tag de de container met cinema-users.

4. Als de build klaar is controleer dat de image aanwezig is.


7: Start de containers
----------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 8.

1. Vanaf de command-line voer je het volgende uit:

- Traefik

```
docker run --name cinema-traefik -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock cinema-traefik
```

We koppelen voor de Traefik container de docker socket van de host met de docker socket van de Traefik container. 
Hierdoor worden de API containers automatisch toegevoegd aan de Traefik loadbalancer aan de hand van een `LABEL` definitie.

- MongoDB

```
docker run --name db -d db 
docker exec db /backup/restore.sh
```
Je voert met `docker exec db /backup/restore.sh` een extra actie uit om MongoDB van data te voorzien.

- cinema-bookings

```
docker run --name cinema-bookings --link db:db -d cinema-bookings
```
Met de flag `--link` maken we een verbinding mogelijk naar MongoDB.

**Bron:** https://docs.docker.com/network/links/#communication-across-links

- cinema-showtimes

```
docker run --name cinema-showtimes --link db:db -d cinema-showtimes
```

- cinema-movies

```
docker run --name cinema-movies --link db:db -d cinema-movies
```
Met de flag `--link` maken we een verbinding mogelijk naar MongoDB.

- cinema-users

```
docker run --name cinema-users --link db:db -d cinema-users
```

2. Roep de API's aan in je browser.

**Tip:** Gebruik een browser extentie als postman(Chrome) of RESTClient(Firefox).

## User Service

This service returns information about the users of Cinema.

**_Routes:_**

* GET - http://users.local/users : Get all users
* POST - http://users.local/users : Create user
* DELETE - http://users.local/users/{id} : Remove user by id

## Movie Service

This service is used to get information about a movie. It provides the movie title, rating on a 1-10 scale, director and other information.

**_Routes:_**

* GET - http://movies.local/movies : Get all movies
* POST - http://movies.local/movies : Create movie
* GET - http://movies.local/movies/{id} : Get movie by id
* DELETE - http://movies.local/movies/{id} : Remove movie by id

## Showtimes Service

This service is used get a list of movies playing on a certain date.

**_Routes:_**

* GET - http://showtimes.local/showtimes : Get all showtimes
* POST - http://showtimes.local/showtimes : Create showtime
* GET - http://showtimes.local/showtimes/{id} : Get showtime by id
* DELETE - http://showtimes.local/showtimes/{id} : Remove showtime by id

## Booking Service

Used to lookup booking information for users.

**_Routes:_**

* GET - http://bookings.local/bookings : Get all bookings
* POST - http://bookings.local/bookings : Create booking

## Traefik Dashboard

* http://ec2-instance:8080


3. Controleer de huidig draaiende containers.

   ```
   docker container list
   ```


8: Debugging container
----------------------

Is je container niet goed opgestart? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

    Let op `CONTAINER ID` en `NAMES` van een failed container. Die hebben we bij de volgende stap nodig.

2. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` met een container uit de vorige stap. 

    Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is.

9: Stop en verwijder de containers
----------------------------------

Ga naar de `done` directory en maak gebruik van het `make` commando `make cleanup`.