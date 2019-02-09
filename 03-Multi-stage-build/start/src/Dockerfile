FROM node:alpine AS build

WORKDIR /usr/src/app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx

EXPOSE 80

COPY --from=build /usr/src/app/build /usr/share/nginx/html
