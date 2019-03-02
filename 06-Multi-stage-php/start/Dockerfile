FROM ... AS ...
 
# install composer
RUN apk update \
    && apk add ca-certificates coreutils \
    && wget -q https://getcomposer.org/installer -O composer-setup.php \
    && wget -q https://composer.github.io/installer.sha384sum -O installer.sha384sum \
    && sha384sum installer.sha384sum \
    && php composer-setup.php --install-dir /usr/local/bin

COPY ...
COPY ...
COPY ...

WORKDIR /app/

RUN composer.phar install --no-dev --classmap-authoritative

FROM ...

COPY --from=... /app /app

CMD ["/app/bin/hello"]
