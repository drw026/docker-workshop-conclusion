Docker Compose
==============

Met Docker compose kun je meerdere containers samen laten draaien. 
In de `docker-compose.yml` specificeer je voor iedere container de `docker build` en de `docker run` parameters. 


Docker compose
--------------

Je gaat een Docker compose bestand maken. 

**Let op:** YAML bestanden springen in met 2 spaties. 

1. Maak in de start directory een `docker-compose.yml` bestand. 

2. Zet de volgende regel aan het begin.

   ```
   version: '3'
   ```

   Versie 3 is de laatst beschikbare versie. Voor meer informatie ga je naar [compose-file](https://docs.docker.com/compose/compose-file/).

3. Voeg de volgende regel toe:

   ```
   services:
   ```

   Hiermee begin je een lijst met "services" of images.

4. Inspringen met 2 spaties en voeg de volgende service toe. 

   ```
     backend:
   ```

   Dit is het begin voor de backend.

5. Inspringen met nog 2 spaties. De build details. 

   ```
       build: backend
   ```

   Hiermee wordt de `Dockerfile` in de backend directory gebuild.

6. Op hetzelfde niveau van build, voeg de volgende regels toe.

   ```
       ports:
       - "5000"
    ```

    Hier wordt alleen een interne poort aangegeven. De backend wordt niet gepubliceerd voor de buiten wereld.

7. In het volgende deel definieren we de frontend container.

   ```
     frontend:
   ```

   Dit is het begin van de definitie voor de frontend.

8. Inspringen met 2 spaties vanaf frontend gezien.

   ```
       build: frontend
   ```

   Hiermee build de `Dockerfile` in de frontend directory.

9. Op hetzelfde niveau van build, voeg de volgende regels toe.

   ```
       ports:
       - "3000:3000"
   ```

   We specificeren twee poorten, zodat de frontend gepubliceerd wordt op poort 3000.

10. Op hetzelfde niveau als build en ports, voeg de volgende regels toe.

    ```
        links:
        - backend
    ```

    Hiermee wordt de hosts file van de frontend container gevuld met het IP adres en naam van de backend container. 
    Hierdoor kun je vanuit de frontend de volgende referentie gebruiken `http://backend:5000/`.

11. Open de `frontend/routes/index.js` en wijzig de regel met `const BACKEND = 'http://172.17.0.2:5000';`. 

    ```
    const BACKEND = 'http://backend:5000';
    ```

12. Om Docker compose te gebruiken voer je het volgende uit. 

    ```
    docker-compose up -d
    ```

    De flag `-d` zorgt ervoor dat de containers in daemon mode draaien op de achtergrond.

13. Open met een browser [http://ec2-instance:3000](http://ec2-instance:3000/).

14. Je kunt de standaard docker commando's `docker image list` en `docker container list` gebruiken om de images en de containers te zien die Docker compose heeft gemaakt.

15. Om Docker composer te stoppen.

    ```
    docker-compose down
    ```

    Als je de container stopt zonder `docker-compose` te gebruiken zal Docker-compose automatisch weer een nieuwe container starten, omdat de applicatie zoals gedefinieerd in de docker-compose.yaml dan niet compleet is.
