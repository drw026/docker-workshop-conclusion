Volumes
=======

In deze opdracht gaan we volumes gebruiken voor opslag. Bij een volume moet je denken aan een directory uit je container die je koppelt met een directory van je host.

Setup
-----

1. Open een terminal en ga naar de `04-Volumes/start` directory.

2. Build de container: `docker build -t volumetest:0.1 .`


Het probleem
------------

1. Start de container: `docker run -p 3000:3000 -d volumetest:0.1`

2. Krijg je een "port in use error"? Kijk dan naar de containers die gestart zijn `docker container list` en stop de container die poort 3000 in gebruik heeft. Zoek eventueel in de eerdere opdrachten hoe je dit gedaan hebt.

3. Browse naar [http://ec2-instance:3000](http://ec2-instance:3000) en upload een bestand.

4. Klik op [See files](http://ec2-instance:3000/files) en zie het bestand die je zojuist geupload hebt.

5. Stop de container met `docker container list` en `docker container stop ...` vervang de `...` met de container naam of id.

6. Verwijder de container met `docker container rm ...` en vervang de `...` met de container naam of id. 

7. Start de container opnieuw `docker run -p 3000:3000 -d volumetest:0.1`

8. Klik op [See files](http://ec2-instance:3000/files).

De eerste container is verwijderd en in de nieuwe container is het bestand dat je geupload hebt weg.

In de meeste gevallen is dit wat je wilt namelijk een geisoleerde omgeving waar binnen niks wijzigt _"stateless"_ en die je kan verwijderen en ergens anders opnieuw kan starten. 

In dit geval willen de data juist wél opslaan, dus laten we gaan experimenteren met volumes.

9. Stop de docker container. 

    We gaan voor de oplossing een nieuwe container maken en willen geen conflicterende poorten.


De oplossing
------------

1. Open de `Dockerfile`.

2. Voeg de volgende regel toe `VOLUME ["/app/public"]` onder de `EXPOSE` regel. 

    (technisch gezien kun je de regel ook ergens anders toevoegen)

3. Build de container `docker build -t volumetest:0.2`. 
Merk op dat de `npm init` niet opnieuw gedaan is. Caching!

4. Maak een lege upload directory aan.

5. Start de nieuwe image `docker run -p 3000:3000 -v $PWD/upload:/app/public -d volumetest:0.2` vervang `/pad/naar/start/upload` met de directory uit stap 4.

6. Browse naar [http://ec2-instance:3000](http://ec2-instance:3000) en upload een bestand. Klik op [See ./files](http://ec2-instance:3000/files) en zie het bestand dat je zojuist geupload hebt.

7. Het bestand staat nu in de upload directory die je gekoppeld hebt. 

8. Stop de container en start de container opnieuw.

    ```
    docker container stop ...
    docker containter start ...
    ```
    
    Of verwijder de container.

    ```
    Docker container stop ...  
    docker container rm ...
    docker run ...
    ```

9. Klik op [See ./files](http://ec2-instance:3000/files) en het bestand wat je geupload had staat er nog.

Volume links kunnen volledige paden zijn, maar bijvoorbeeld ook `.` voor de huidige directory of `~` voor je home directory.
