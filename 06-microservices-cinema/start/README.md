Microservices - Cinema app
==========================

traefik
-------
- mkdir traefik
- vim Dockerfile
- create `src/traefik.toml` config

- build
```
docker build -t cinema-traefik .
```

- run
``` 
docker run -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock cinema-traefik
```

bookings
--------
- add labels
`LABEL traefik.backend=bookings`
`LABEL traefik.frontend.rule=Host:bookings.local`

- build 
```
docker build -t cinema-bookings .
```

- run
```
docker run --name cinema-bookings -d cinema-bookings
```

showtimes
---------
- add labels
`LABEL traefik.backend=showtimes`
`LABEL traefik.frontend.rule=Host:showtimes.local`

- build
```
docker build -t cinema-showtimes .
```

- run
```
docker run --name cinema-showtime -d cinema-showtimes
```

movies
------
- add labels
`LABEL traefik.backend=movies`
`LABEL traefik.frontend.rule=Host:movies.local`

- build
```
docker build -t cinema-movies .
```

- run
```
docker run --name cinema-movies -d cinema-movies
```

users
------
- add labels
`LABEL traefik.backend=users`
`LABEL traefik.frontend.rule=Host:users.local`

- build
```
docker build -t cinema-users .
```

- run
```
docker run --name cinema-users -d cinema-users
```

db
--- 
- mkdir mongo 
- mv backup mongo
- vim Dockerfile
- build
- run
```
docker run --name db -d db 
docker exec db /backup/restore.sh
```




run script
----------
```
#!/bin/bash

docker run --name cinema-traefik -d -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock cinema-traefik
docker run --name db -d db 
docker exec db /backup/restore.sh
docker run --name cinema-bookings --link db:db -d cinema-bookings
docker run --name cinema-showtimes --link db:db -d cinema-showtimes
docker run --name cinema-movies --link db:db -d cinema-movies
docker run --name cinema-users --link db:db -d cinema-users
```


API Documentatie
----------------
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