Hello World
===========

We gaan onze eerste container draaien.

1: Start een nginx container
---------------------------

1. Voer het volgende commando uit

   ```
   docker container run -d nginx
   ```

Hiermee wordt de image `nginx`, versie `latest` als container. `-d` zorgt ervoor dat de container in daemon mode draait op de achtergrond.

2. Zie de huidig draaiende container.

   ```
   docker container list
   ```
3. Voer het volgende commando uit

   ``` 
   docker image list
   ```

4. Stop de container

   ```
   docker container stop ... 
   ```
   Vervang `...` met de `CONTAINER ID` uit stap 2

5. Image

   ```
   docker image list
   ```
   De image bestaat nog steeds. De container die we gemaakt hebben op basis van de image is weg.
