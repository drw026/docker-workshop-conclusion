Multi-stage Build met React
============================

In de vorige opdrachten hebben we de source-code in onze container gekopieerd. In deze opdracht gaan we eerst de code builden en daarna deployen we de gemaakte artifacts.

Door gebruik te maken van *multi-stage builds* kunnen we de uit eindelijke container klein houden, omdat we de build tools en source-code niet deployen.


1: Maken van de Dockerfile
--------------------------

1. Maak een nieuwe `Dockerfile` in de `src` directory.

2. Voeg de volgende regel toe:

   ```
   FROM node:alpine
   ```

   Dit geeft aan start met de [node](https://hub.docker.com/_/node/) base-image en specifiek de alpine variant.

3. Voeg de volgende regel toe:

   ```
   WORKDIR /usr/src/app
   ```

   Met deze regel start het process vanaf de `/usr/src/app` directory. De directory wordt aangemaakt als die nog niet bestaat.


4. Voeg de volgende regel toe:

   ```
   COPY package.json package-lock.json /usr/src/app/
   ```

   Met deze regel kopieer je de `package.json` en `package-lock.json` van jouw systeem naar de huidige directory in de image.

5. Voeg de volgende regel toe:

   ```
   RUN npm install
   ```

   Hiermee worden de packages en dependencies geinstalleerd die nodig zijn voor onze applicatie. 

   We kopiëren de `package.json` en `package-lock.json` eerst, zodat we optimaal gebruik kunnen maken van de Docker layer caching. Wanneer we de source code van de applicatie aanpassen en de image opnieuw builden worden de npm packages niet opnieuw gedownload. 
   Zeker bij applicaties met veel npm packages en dependecies is de build tijd dan drastisch korter.

6. Voeg de volgende regel toe:

   ```
   COPY . .
   ```

   Deze regel kopieert de rest van de bestanden in je huidige directory naar de huidige directory in de image.

7. Open de `.dockerignore` in de `src` directory. De syntax is gelijk aan een `.gitignorre` bestand. Hiermee kun je aangeven welke bestanden het `COPY` commando _niet_ mee moet nemen. 

   Als je geen `.dockerignore` hebt, wordt de `.gitignore` gebruikt. Als die ook niet bestaat dan wordt alles gekopieerd.

8. In de `Dockerfile` voeg de volgende regel toe:

   ```
   RUN npm run build
   ```

   Hiermee wordt de applicatie gebuild. Het bundelt de react en optimaliseert het voor de beste performance. 
   Het "minified" de code en de bestanden worden gehashed. De applicatie is nu klaar om gedeployed te worden. 
   
9. Voeg de volgende regel toe:

   ```
   EXPOSE 3000
   ```

   Deze regel opent poort 3000 voor verkeer van buitenaf.

10. Voeg de volgende regel toe:

   ```
   CMD ["npm", "start"]
   ```

   Deze regel geeft het commando aan waarmee de container opstart `npm start`.

11. Sla de `Dockerfile` op.


2: Maak een image aan met de Dockerfile
---------------------------------------

1. Vanuit de `src` directory met de `Dockerfile`, voer je het volgende commando uit. 

   ```
   docker build --tag hello-react:0.1 .
   ```

   Hiermee maak je een image op basis van de Dockerfile en tag je de image met de naam `hello-react` en versie `0.1`.

2. Als de build klaar is. Controleer je dat de image aanwezig is.

   ```
   docker image list
   ```
   
   Jouw image staat bovenaan de lijst, omdat de lijst op aangemaakte datum gesorteerd is met de laatste bovenaan.



3: Draai de container image
---------------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 4.

1. Vanaf de command-line voer je het volgende uit.

   ```
   docker run -p 3000:3000 -d hello-react:0.1
   ```

   Hiermee wordt de image `hello-react`, versie `0.1` als container gestart. Poort 3000 wordt getNAT van de host naar poort 3000 in de container. De flag `-d` zorgt ervoor dat de container in daemon mode draait op de achtergrond.

2. Roep met curl de url aan [http://localhost:3000](http://localhost:3000).

    Of open met een browser `http://<ec2-instance>:3000`.
   
   ```
   curl http://localhost:3000
   ```

3. Controleer de huidig draaiende container.

   ```
   docker container list
   ```

   Draait je container niet? Zie deel 4.

**Note: Je hebt node zelf niet hoeven te installeren**


4: Debugging container
----------------------

Is je container niet goed opgestart in deel 4? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

    Let op `CONTAINER ID` en `NAMES` van een failed container. Die hebben we bij de volgende stap nodig.

2. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` met een container uit de vorige stap. 

    Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is.

3. Verwijder de container met het stop commando uit deel 6. Ga dan terug naar deel 3 en rebuild de image en run de container opnieuw.

4. Start de container met `docker run -p 3000:3000 hello-react:0.1` zonder `-d` de console output komt direct op je scherm.

5. Als je genoeg gezien hebt, gebruik dan CTRL-C om terug te gaan naar je host's terminal.

Is poort 3000 al in gebruik op je systeem. Je kunt de poort wijzigen naar bijvoorbeeld 3001 door `docker run -p 3001:3000 hello-react:0.1` uit te voeren. 
Open dan de volgende URL ```curl localhost:3001``` of ```http://<ec2-instance>:3001```

5: Stop en verwijder de container
---------------------------------

1. `docker container list --all` -- Zie alle container beide gestopt en gestart. Let op `CONTAINER ID` en `NAMES` van de running container.

2. `docker container rm -f ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee stop en verwijder je de container.

3. `docker image list`.  -- De image bestaat nog steeds. De container die we gemaakt hebben op basis van de image is weg.

6: Verander de Dockerfile naar een multi-stage
----------------------------------------------

1. Open de `Dockerfile`.

2. Voeg de volgende regel toe na `RUN npm run build` en voor `EXPOSE 3000` line:

   ```
   FROM nginx
   ```

   Met deze tweede `FROM` begin je een tweede build stap. Deze maakt gebruik van de nginx image.

3. Verander de `EXPOSE 3000` regel.

   ```
   EXPOSE 80
   ```

4. Voeg de volgende regel toe:

   ```
   COPY --from=build /usr/src/app/build /usr/share/nginx/html
   ```

   Deze regel gebruikt de `--from=build`, hiermee kopiëren we bestanden van de image `build` naar de container.
   
5. Verander bovenaan de `FROM node:alpine` naar:

   ```
   FROM node:alpine AS build
   ```
   
   De eerste image heeft nu een naam gekregen en het `COPY` commando kan dit gebruiken.

6. Sla de `Dockerfile` op.


7: Build de multi-stage image
-----------------------------

1. Vanuit de `src` directory met de `Dockerfile`, voer je het volgende commando uit. 

   ```
   docker build --tag hello-react:0.2 .
   ```
   Hiermee maak je een image op basis van de `Dockerfile` en tag je de image met de naam `hello-react` en versie `0.2`.

2. Als de build klaar is. Controleer je of de image aanwezig is.

   ```
   docker image list
   ```


8: Draai de container image
---------------------------

1. Draai de image als container. We NATten poort 80 van het systeem naar de container: 

   ```
   docker run --name hello-react -p 80:80 -d hello-react:0.2
   ```

2. Open met je browser [http://ec2-instance](http://<ec2-instance>).

3. Controleer de huidig draaiende container.

   ```
   docker container list
   ```

   Draait je container niet? Zie deel 4.


9: Stop en verwijder de container
---------------------------------

1. Zoals je gedaan hebt in stap 5. Kijk naar de output van de draaiende containers, stop en verwijder de hello-react container. 

    Maak anders gebruik van het `make` commando `make cleanup`.

10: Images
----------

Het doel met de multi-stage build is om een kleine image te maken. Controleer of dit gelukt is.

1. Vanaf de command-line:

   ```
   docker image list
   ```

   In de meest rechtse kolom kun je de size zien van de images. Kijk naar de images `hello-react:0.1` en `hello-react:0.2`.
   De `0.2` versie is veel kleiner dan de `0.1` versie. 

Docker heeft twee images gemaakt. Een heet `<none>` en heeft de node applicatie die de source-code gebuild heeft. De andere is `hello-react:0.2` en is vele malen kleiner. 

Dit kun prima toepassen voor een productie omgeving. De uiteindelijke image is klein en heeft geen build tools die je niet op je productie omgeving wilt hebben.

11: Verwijderen van de _none_ images
------------------------------------

Alleen als je _geen_ gebruik hebt gemaakt van `make cleanup`.

1. Vanaf de command-line kijk naar de lijst met images.

2. Zie de image met `<none>`, dit is de image gemaakt door het build process. Docker heeft deze gecached, zodat een volgende build sneller is.

3. Voer het volgende uit:

   ```
   docker image prune -f
   ```
   
   Dit verwijderd alle images met `<none>`. Alle andere images blijven staan. 
   
4. Controleer dat alle images met `<none>` weg zijn.

   Zijn er nog steeds `<none>` images?  
   
   Controleer met `docker container list --all` en kijk of er nog running containers zijn.