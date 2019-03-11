#!/bin/bash


allImages=(nginx node:alpine microsoft/dotnet:2.1-aspnetcore-runtime-alpine microsoft/dotnet:2.1-sdk-alpine php:7.3-apache php:7.3-alpine golang:1.11.2 mongo traefik:alpine postgres redis:alpine python:3.6.2-slim)

for images in ${allImages[@]}; do
  docker pull $images
done