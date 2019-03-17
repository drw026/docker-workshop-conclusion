Multi-stage Build met php
============================

In deze opdracht ga je zelf aan de slag om een applicatie te maken die gebruikt maakt van een multi-stage build.

De applicatie is een PHP applicatie en jij moet er voor zorgen dat de `Dockerfile` aangevuld wordt, zodat het een werkende applicatie oplevert.


***Image:*** [PHP](https://hub.docker.com/_/php/)

1: Maak de applicatie
---------------------

Kijk voor informatie over de image naar de PHP link hierboven.


1. Open de `Dockerfile` en vul de `Dockerfile` verder aan.

2. Build de container.
    - Tag de container met `ms-php`

3. Als de build klaar is controleer dat je image aanwezig is.

4. Run de container image.

   ```
   docker run --name ms-php ms-php
   ```

Als de container image werkt krijg je de text "Hello" als output.