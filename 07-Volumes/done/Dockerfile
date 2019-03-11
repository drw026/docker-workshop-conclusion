FROM node:alpine

WORKDIR /app

COPY src/package.json /app
RUN npm install

COPY src /app

EXPOSE 3000
VOLUME ["/app/public"]

CMD ["node", "server"]
