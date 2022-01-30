---
title: Django and NGINX in Docker
type: post
date: 2022-01-30T22:00:00+03:00
categories:
  - Uncategorized
tags:
  - django
  - nginx
  - docker
  - linux
  - python
---

In this post we will run Django application behind a NGINX webserver, which is a very common practice
in production.

<!--more-->

We will configure NGINX to serve static files directly, and forward everything else to Django app.


## Configure Django static file location

Here we will configure the location where the static file are located in our file system, so when
we use "collectstatic" command it will put them in this location:

apps/settings.py:

    STATIC_URL = '/static/'
    STATIC_ROOT = '/www/static/'
    MEDIA_URL = '/media/'
    MEDIA_ROOT = '/www/media/'


## Django App Dockerfile

Nothing special here, a minimal Dockerfile for Django, notice ``PYTHONUNBUFFERED`` environment 
variable!

Dockerfile:

    FROM python:3.9-slim
    ENV PYTHONUNBUFFERED 1
    WORKDIR /app
    COPY requirements.txt /app
    RUN pip install -r requirements.txt
    COPY apps /app
    EXPOSE 8000
    CMD ["python", "./apps/manage.py", "runserver", "0.0.0.0:8000"]


## Configure NGINX Container

Docker NGINX container has a neat feature where you can override NGINX configuration
with a template file that uses environment variables, notice ``${DJANGO_HOST}``

default.conf.template:

    upstream app {
        server ${DJANGO_HOST}:8000;
    }

    server {

        listen 80;

        location ~ /(media|static)/ {
            root /www/;
            expires 30d;
        }

        location / {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            proxy_pass   http://app;
        }

    }


## Docker Compose 

Here we will connect the pieces together, a ``web`` container, and an ``app`` container, they share ``/www`` volume!

docker-compose.yml:

    version: "3"
    services:

    web:
        image: nginx:stable
        restart: always
        ports:
        - 8080:80
        environment:
        - DJANGO_HOST=app
        volumes:
        - ./default.conf.template:/etc/nginx/templates/default.conf.template
        - ./www:/www
        networks:
        - backend

    app:
        build: .
        restart: always
        ports:
        - 8000:8000
        environment:
        POSTGRES_DB: dj
        POSTGRES_USER: dj
        POSTGRES_PASSWORD: should_use_env
        POSTGRES_HOST: db
        volumes:
        - .:/app
        - ./www:/www
        networks:
        - backend

    networks:
        backend:


## Starting 

    docker-compose up -d
    docker-compose exec  app  ./apps/manage.py collectstatic --noinput

Now you can access it:

- NGINX: http://localhost:8080
- Django: http://localhost:8000
