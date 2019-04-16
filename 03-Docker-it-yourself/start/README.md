Docker it yourself
==================

In deze opdracht ga je toepassen wat je in de vorige opdrachten geleerd hebt. Je kunt altijd even spieken in de `done` map mocht je er niet uitkomen.

Voor deze opdracht ga je een PHP applicatie maken. Gebruik hiervoor de PHP image van docker hub. Zie de image link hieronder en zoek naar php:<version>-apache voor meer informatie over hoe je de image kunt opbouwen voor deze opdracht.

***Image:*** [PHP](https://hub.docker.com/_/php/)

1: PHP-apache
-------------

1. Maak een apache webserver container met php aan de hand van de volgende voorwaarden.
    - Maak een Dockerfile.
    - Kopieer de `src/index.php` in de container op de juiste plek. 

    Kijk voor informatie over de image naar de PHP link hierboven.

2. Build de container.
    - Tag de de container met docker-it-youself.

3. Als de build klaar is controleer dat je image aanwezig is.

4. Run de container image en zorg dat poort 80 naar de container geNAT is op poort 80.

5. Controleer je werk.

   ```
   curl localhost
   Hoi. De datum van vandaag is: Thursday the 21th.
   ```

    Of open met een browser `http://<ec2-instance>`.

6. Stop en en verwijder de container.

    Dit kun je doen door `docker container stop ...` en `docker container rm ...`.

    Ga anders naar de `done` directory en voer `make cleanup` uit.
