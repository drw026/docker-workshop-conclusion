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

Voeg achter eerste regel in de `/etc/hosts` het volgende toe. 
movies.local bookings.local users.local showtimes.local monitor.local


1: Traefik
----------

1. Maak een Traefik loadbalancer container aan de hand van de volgende voorwaarden.
    - Maak een Dockerfile voor de Traefik loadbalancer
    - Gebruik de alpine versie voor de image. 
    - Zorg dat de `src/traefik.toml` gekopieerd wordt in de container naar `/etc/traefik/traefik.toml`. 
    - Traefik moet beschikbaar zijn op poort 80
    - Traefik dashboard moet beschikbaar zijn op poort 8080

2. Build de traefik container
    - Tag de de container met cinema-traefik

3. Als de build klaar is controleer dat je image aanwezig is.

4. Start de Traefik loadbalancer.

  ```
   docker run --name cinema-traefik -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock cinema-traefik
   ```

We doen voor de Traefik container de docker socket van de host koppelen met de docker socket van de traefik container. 
Door worden de API containers automatisch toegevoegd aan de Traefik loadbalancer.


2: MongoDB
----------

1. Maak een MongoDB database container

2. Build de MongoDB container
    - Tag de de container met cinema-mongo

3. Als de build klaar is, controleer dat je image aanwezig is.

4. Start de MongoDB container

   ```
   docker run --name db -d db 
   docker exec db /backup/restore.sh
   ```


3: API - bookings
-----------------

1. Maak een Dockerfile voor bookings
`LABEL traefik.backend=bookings`
`LABEL traefik.frontend.rule=Host:bookings.local`

2. Build de bookings container
    - Tag de de container met cinema-bookings

3. Als de build klaar is controleer dat je image aanwezig is.

4. Start de booking container


4: API - movies
---------------

1. Maak een Dockerfile voor movies
`LABEL traefik.backend=movies`
`LABEL traefik.frontend.rule=Host:movies.local`

2. Build de movies container
    - Tag de de container met cinema-movies

3. Als de build klaar is controleer dat je image aanwezig is.

4. Start de movies container


5: API - showtimes
------------------

1. Maak een Dockerfile voor showtimes
`LABEL traefik.backend=showtimes`
`LABEL traefik.frontend.rule=Host:showtimes.local`

2. Build de showtimes container
    - Tag de de container met cinema-showtimes

3. Als de build klaar is controleer dat je image aanwezig is.

4. Start de showtimes container


6: API - users
--------------

1. Maak een Dockerfile voor users
`LABEL traefik.backend=users`
`LABEL traefik.frontend.rule=Host:users.local`

2. Build de users container
    - Tag de de container met cinema-users

3. Als de build klaar is controleer dat je image aanwezig is.

4. Start de users container


7: Start de containers
----------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 8.

1. Vanaf de command-line voer je het volgende uit.

   ```
   docker run --name cinema-traefik -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock cinema-traefik
   docker run --name db -d db 
   docker exec db /backup/restore.sh
   docker run --name cinema-bookings --link db:db -d cinema-bookings
   docker run --name cinema-showtimes --link db:db -d cinema-showtimes
   docker run --name cinema-movies --link db:db -d cinema-movies
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

Traefik Dashboard
======================

Access to the dashboard to see how Traefik organize the links.

* http://monitor.local : Get Traefik dashboard   

3. Controleer de huidig draaiende containers.

   ```
   docker container list
   ```


8: Debugging container
----------------------

Is je container niet goed opgestart? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

2. Let op `CONTAINER ID` en `NAMES` van failed container.  Die hebben we bij de volgende stap nodig.

3. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is?

4. Verwijder de container met het stop commando uit deel 6. Ga dan terug naar deel 3 en rebuild de image en run de container opnieuw.

5. Start de container met `docker run IMAGE` zonder `-d` de console output komt direct op je scherm.

6. Als je genoeg gezien hebt, gebruik dan CNTRL-C om terug te gaan naar je host's terminal.


9: Stop en verwijder de containers
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
