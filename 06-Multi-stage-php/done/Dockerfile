FROM php:7.3-alpine AS builder
 
# install composer
RUN apk update \
    && apk add ca-certificates coreutils \
    && wget -q https://getcomposer.org/installer -O composer-setup.php \
    && wget -q https://composer.github.io/installer.sha384sum -O installer.sha384sum \
    && sha384sum installer.sha384sum \
    && php composer-setup.php --install-dir /usr/local/bin

COPY src/composer.* /app/
COPY src/src /app/src
COPY src/bin /app/bin

WORKDIR /app/

RUN composer.phar install --no-dev --classmap-authoritative

FROM php:7.3-alpine

COPY --from=builder /app /app

CMD ["/app/bin/hello"]
