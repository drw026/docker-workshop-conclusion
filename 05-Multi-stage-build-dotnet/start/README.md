Multi-stage Build met .NET Core
================================

In .NET Core hanteren we hetzelfde principe van een builden en daarna deployen van de artifacts. 
Door gebruik te maken van een multi-stage build houden we de container klein.


1: Maken van de Dockerfile
--------------------------

1. Maak een nieuw bestand in de `src` directory en noem het `Dockerfile`

2. Voeg de volgende regel toe:

   ```
   FROM microsoft/dotnet:2.1-sdk-alpine
   ```

   Dit geeft aan start met de [.net build tools](https://hub.docker.com/r/microsoft/dotnet/) base-image en specifiek de alpine variant.

3. Voeg de volgende regel toe:

   ```
   WORKDIR /src
   ```

   Met deze regel start het process vanaf de `/src` directory. De directory wordt aangemaakt als die nog niet bestaat.

4. Voeg de volgende regel toe:

   ```
   COPY MultiStage.csproj .
   ```

   Met deze regel kopieer je de csproj van jouw systeem naar de huidige directory in de image.


5. Voeg de volgende regel toe:

   ```
   RUN dotnet restore MultiStage.csproj
   ```

   Hiermee download je de voor de NuGet package repository.

   We kopieeren het manifest als eerst, zodat we optimaal gebruik kunnen maken van de Docker layer caching. Wanneer we de source code van de applicatie aanpassen en de image opnieuw builden worden de libraries niet opnieuw gedownload.

6. Voeg de volgende regel toe:

   ```
   COPY . .
   ```

   Deze regel kopieert de rest van de bestanden in je huidige directory naar de huidige directory in de image.

7. Open de `.dockerignore` in de `src` directory. De syntac is gelijk aan een `.gitignorre` bestand. Hiermee kun je aangeven welke bestanden het `COPY` commando _niet_ mee moet nemen. 

   Als je geen `.dockerignore` hebt, wordt de `.gitignore` gebruikt. Als die ook niet bestaat dan wordt alles gekopieerd.

8. In de `Dockerfile` voeg de volgende regels toe:

   ```
   RUN dotnet build MultiStage.csproj -c Release
   RUN dotnet publish MultiStage.csproj -c Release -o /app
   ```

   Hiermee builden we de .NET Core applicatie en publiceren we de applicatie in de `/app` directory. De directory wordt aangemaakt mocht die nog niet bestaan.

9. Voeg de volgende regel toe:

   ```
   WORKDIR /app
   ```

   Deze regel hebben we nu een aantal keren gezien. 
   Strict gezien doet dit "mkdir -p /app && cd /app"

10. Voeg de volgende regels toe:

   ```
   ENV ASPNETCORE_URLS http://+:5000
   EXPOSE 5000
   ```

   Deze regels vertellen .NET en Docker welke poorten te gebruiken voor de web-server. 

11. Voeg de volgende regel toe:

    ```
    CMD ["dotnet", "MultiStage.dll"]
    ```

    Dit is het commando wat uitgevoerd wordt als de container start. De regels die je eerder toegevoegd hebt worden uitgevoerd tijdens de build. We starten hiermee de webserver.

12. Sla de Dockerfile op.


2: Maak een image aan met de Dockerfile
---------------------------------------

1. Vanuit de `src` directory met de `Dockerfile`, voer je het volgende commando uit. 

   ```
   docker build --tag hello-dotnet:0.1 .
   ```

   Hiermee maak je een image op basis van de Dockerfile en tag je image met de naam `hello-dotnet` en versie `0.1`.
   
2. Als de build klaar is. Controleer je od de image aanwezig is.

   ```
   docker image list
   ```
   
   Jouw image staat bovenaan de lijst, omdat de lijst op aangemaakte datum gesorteerd is met de laatste bovenaan.


3: Draai de container image
---------------------------

Als je tegen problemen aanloopt tijdens het uitvoeren van de volgende stappen kijk dan naar de tips in deel 4.

1. Vanaf de command-line voer je het volgende uit.

   ```
   docker run -p 5000:5000 -d hello-dotnet:0.1
   ```

   Hiermee wordt de image `hello-dotnet`, versie `0.1` als container gestart. Poort 5000 wordt getNAT van de host naar poort 5000 in de container. `-d` zorgt ervoor dat de container in daemon mode draait op de achtergrond.

2. Open een browser naar [http://localhost:5000](http://localhost:5000).  Success!

3. Ziet de huidig draaiende container.

   ```
   docker container list
   ```

   Draait je container niet? Zie deel 4.

**Note: Je hebt .NET Core zelf niet hoeven te installeren**


4: Debugging container
----------------------

Is je container niet goed opgestart in deel 4? Dan vind je hier stappen om dit te onderzoeken.

1. `docker container list --all`.  Dit laat alle draaiende en niet draaiende containers zien.

2. Let op `CONTAINER ID` en `NAMES` van failed container.  Die hebben we bij de volgende stap nodig.

3. `docker container logs ...`, vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Dit laat de console output zien van de container.
    Wellicht geeft het een hint waarom de container gefailed is?

4. Verwijder de container met het stop commando uit deel 6. Ga dan terug naar deel 3 en rebuild de image en run de container opnieuw.

5. Start de container met `docker run -p 5000:5000 hello-dotnet:0.1` zonder `-d` de console output komt direct op je scherm.

6. Als je genoeg gezien hebt, gebruik dan CNTRL-C om terug te gaan naar je host's terminal.

Is poort 5000 al in gebruik op je systeem. Je kunt de poort wijzigen naar bijvoorbeeld 5001 door `docker run -p 5001:5000 hello-dotnet:0.1` uit te voeren. 
Open dan de volgende url ```curl localhost:5001```


5: Stop en verwijder de container
---------------------------------

1. `docker container list --all` -- Zie alle containers beide gestopt en gestart. Let op `CONTAINER ID` en `NAMES` van de running containers.

2. `docker container rm -f ...` vervang `...` met de `CONTAINER ID` of `NAMES` uit de vorige stap. Hiermee stop en verwijder je de container.

3. `docker image list`.  -- De image bestaat nog steeds. De container die we gemaakt hebben op basis van de image is weg.


6: Verander de Dockerfile naar een multi-stage
----------------------------------------------

1. Open de `Dockerfile`.

2. Voeg de volgende regel toe na `RUN dotnet publish ...` en voor de regel `WORKDIR /app`:

   ```
   FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine
   ```

   Met deze tweede `FROM` begin je een tweede build stap. Deze maakt gebruik van de .NET Core runtime. Deze image is exclusief build tools en daardoor veel kleiner.


3. Voeg de volgende regel toe na `WORKDIR /app` en voor de regel `ENV ASPNETCORE_...`:

   ```
   COPY --from=build /app .
   ```

   Deze regel gebruikt de `--from=build`, hiermee kopieeren we bestanden van de image `build` naar de container.


4. Verander bovenaan de `FROM microsoft/dotnet:2.1-sdk-alpine` naar:

   ```
   FROM microsoft/dotnet:2.1-sdk-alpine AS build
   ```

   De eerste image heeft nu een naam gekregen en het `COPY` commando kan dit gebruiken.

5. Sla de Dockerfile op.


7: Build de multi-stage image
---------------------------------------

1. Vanuit de `src` directory met de `Dockerfile`, voer je het volgende commando uit. 

   ```
   docker build --tag hello-dotnet:0.2 .
   ```

   Hiermee maak je een image op basis van de Dockerfile en tag je de image met de naam `hello-dotnet` en versie `0.2`.

2. Als de build klaar is. Controleer je dat de image aanwezig is.

   ```
   docker image list
   ```


8: Draai de container image
---------------------------

1. Draai de image als container. We NATten poort 5000 van het systeem naar de container: 

   ```
   docker run --name hello-dotnet -p 5000:5000 -d hello-dotnet:0.2
   ```

2. Open met je browser [http://localhost:5000](http://localhost:5000).  

3. Controleer de huidig draaiende container.

   ```
   docker container list
   ```

   Draait je container niet? Zie deel 4.


9: Stop en verwijder de container
---------------------------------

1. Zoals je gedaan hebt in stap 5. Kijk naar de output van de draaiende containers, stop en verwijder de hello-dotnet container. 


10: Images
---------------------------

Het doel met de multi-stage build is om een kleinere image te maken. Controleer of dit gelukt is.

1. Vanaf de command-line:

   ```
   docker image list
   ```

   In de meest rechtse kolom kun je de size zien van de images. Kijk naar de images `hello-dotnet:0.1` en `hello-dotnet:0.2`.
   De `0.2` versie is veel kleiner dan de `0.1` versie. 

Docker heeft twee images gemaakt. Een heet `<none>` en heeft de .NET applicatie die de source-code gebuild heeft. De andere is `hello-dotnet:0.2` en is vele malen kleiner. We hebben dit gedaan, omdat we op een productie server geen build tools willen hebben. 


11: Verwijderen van de <none> images
------------------------------------

1. Vanaf de command-line kijk naar de lijst met images.

2. Zie de image met `<none>`, dit is de image gemaakt door het build process. Docker heeft deze gecached, zodat een volgende build sneller is.

3. Voer het volgende uit:

   ```
   docker image prune -f
   ```
   
   Dit verwijderd alle images met `<none>`. Alle andere images blijven staan. 
   
4. Controleer dat alle images met `<none>` weg zijn.

   Zijn er nog steeds `<none>` images?  Controleer met `docker container list --all` en kijk of er nog running containers zijn.