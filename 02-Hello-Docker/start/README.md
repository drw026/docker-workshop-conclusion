Hello Docker
============

We gaan onze eerste container maken.


1: Maak de app
--------------

1. Ga naar [nodejs.org](https://nodejs.org/en/about).

2. Kopier de voorbeeld code.

3. Plak het in een nieuw bestand.

4. Sla het bestand als `server.js` in de start directory.

5. Pas de volgende regel aan `server.listen(port, hostname, () => {` naar: `server.listen(port, () => {` (verwijder `hostname` komma.)


2: Maken van de Dockerfile
--------------------------

1. Maak een nieuw bestand in de start directory en noem het Dockerfile -- Het bestand heeft geen extentie(bijv. .txt)

2. Voeg de volgende regel toe:

   ```
   FROM node:alpine
   ```

   Dit geeft aan start met de [node](https://hub.docker.com/_/node/) base-image en specifiek de alpine variant. 
   De apline Linux staat bekend om dat deze heel klein is.

   **Pro tip:** In plaats van de tekst te kopieren en plakken, typ je alles. Op die manier raak je sneller bekend met nieuwe technologie.
   
3. Voeg de volgende regel toe:

   ```
   WORKDIR /app
   ```

   Met deze regel start het process vanaf de /app directory. De directory wordt aangemaakt als die nog niet bestaat.

4. Volgende regel:

   ```
   COPY . /app
   ```

   Deze regel kopieert alle bestanden in je huidige directory naar de `/app` directory in de image.

4. Volgende regel:

   ```
   EXPOSE 3000
   ```

   Deze regel opent poort 3000 voor verkeer van buitenaf.

5. Volgende regel:

   ```
   CMD ["node", "server"]
   ```

   Deze regel geeft het commando aan waarmee de container opstart `node server`. In andere woorden start Node met de `server.js`.

6. Sla de Dockerfile op


3: Maak een image aan met de Dockerfile
--------------------------------------------

1. Vanuit de directory met de `Dockerfile` en `server.js`, voer je het volgende commando uit. 

   ```
   docker build --tag hellonode:0.1 .
   ```
   Hiermee maak je een image op basis van de Dockerfile en tag je image met de naam `hellonode` en versie `0.1`.

2. Als de build klaar is voer dan het volgende uit.

   ```
   docker image list
   ```
   
   Jouw image staat bovenaan de lijst, omdat de lijst op aangemaakte datum gesorteerd is met de laatste bovenaan.


4: Draai de container image
---------------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 5.

1. Vanaf de command-line voer je het volgende uit.

   ```
   docker run -p 3000:3000 -d hellonode:0.1
   ```

   Hiermee wordt de image `hellonode`, versie `0.1` als container. Poort 3000 wordt getNAT van de host naar poort 3000 in de container. `-d` zorgt ervoor dat de container in daemon mode draait op de achtergrond.

2. Roep met curl de url aan [http://localhost:3000](http://localhost:3000).  Success!
   
   ```
   curl http://localhost:3000
   ```

3. Ziet de huidig draaiende container.

   ```
   docker container list
   ```

   Draait je container niet? Zie deel 5.

**Note: Je hebt node zelf niet hoeven te installeren**


5: Debugging container
----------------------

Is je container niet goed opgestart in deel 4? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

2. Let op `CONTAINER ID` en `NAMES` van failed container.  Die hebben we bij de volgende stap nodig.

3. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is?

4. Verwijder de container met het stop commando uit deel 6. Ga dan terug naar deel 3 en rebuild de image en run de container opnieuw.

5. Start de container met `docker run -p 3000:3000 hellonode:0.1` zonder `-d` de console output komt direct op je scherm.

6. Als je genoeg gezien hebt, gebruik dan CNTRL-C om terug te gaan naar je host's terminal.

Is poort 3000 al in gebruik op je systeem. Je kunt de poort wijzigen naar bijvoorbeeld 3001 door `docker run -p 3001:3000 hellonode:0.1` uit te voeren. 
Open dan de volgende url ```curl localhost:3001```

6: Stop en verwijder de container
---------------------------------

1. `docker container list` -- Let op `CONTAINER ID` en `NAMES` van de running container.

2. `docker container stop ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee stop je de container.

3. `docker container list` -- Zie dat de container nu stopped is.

4. `docker container list --all` -- Zie alle container beide gestop en gestart.

5. `docker container rm ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee verwijder je de container.

6. `docker image list`.  -- De image bestaat nog steeds. De container die we gemaakt hebben op basis van de image is weg.


7: Wijzig de code, rebuild, rerun
---------------------------------

1. Wijzig de `server.js` en wijzig de `Hello World` naar iets anders.

2. `docker build` een nieuwe image met een andere versie.

3. Doe een `docker run` om een nieuwe container te starten container.

4. curl [http://localhost:3000](http://localhost:3000) om te zien of je wijziging is gelukt.

5. Stop de container `docker container stop`.

6. Verwijder de container `docker container rm`.