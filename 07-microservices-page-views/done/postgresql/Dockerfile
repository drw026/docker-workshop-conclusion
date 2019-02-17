FROM postgres

ENV POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=dbPageViews \
    POSTGRES_DB=dbPageViews

COPY src/init.sh /docker-entrypoint-initdb.d/init.sh

EXPOSE 5432