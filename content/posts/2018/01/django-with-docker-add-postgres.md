---
title: 'Django with Docker: Add Postgres'
author: Rayed
type: post
date: 2018-01-24T20:33:26+03:00
categories:
  - Uncategorized
wordpress_id: 2096
tags:
  - django
  - docker
  - linux
  - python

---

In the last post I covered starting a new Django project with Docker, and how to build a custom container image for my project, but what I haven't covered is how to use a Database and how persist your data since all data stored in the container ephemeral and would only exist during the life span of the container.
<!--more-->

Instead of managing the Database inside my container we will use a ready made container, in my case I am going to use [Postgres](https://hub.docker.com/_/postgres/), and to solve data persistence issue we are going to mount Postgres data directory into a named [volume](https://docs.docker.com/storage/volumes/).

But what about telling my Django app where to find the Postgres instance! Luckily this part is easily solved with the use of Docker [Compose](https://docs.docker.com/compose/)

> Compose is a tool for defining and running multi-container Docker applications

We start with creating a new `docker-compose.yml` file describing what services our application consist of:

    version: "3"
    services:

      db:
        image: postgres
        restart: always
        environment:
          POSTGRES_DB: dj
          POSTGRES_USER: dj
          POSTGRES_PASSWORD: should_use_env
        volumes:
          - db-data:/var/lib/postgresql/data
        networks:
          - backend

      web:
        build: .
        restart: always
        depends_on:
          - db
        ports:
          - 8000:8000
        environment:
          POSTGRES_DB: dj
          POSTGRES_USER: dj
          POSTGRES_PASSWORD: should_use_env
          POSTGRES_HOST: db
        volumes:
          - .:/app
        networks:
          - backend

    networks:
      backend:

    volumes:
      db-data:


We need to change some settings in our Django app to add Postgres support, by adding the following line to `requirements.txt`:

    psycopg2==2.7.3.2

and change our database settings by changing the DATABASE section in apps/apps/settings.py:

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': os.environ.get('POSTGRES_DB', ''),
            'USER': os.environ.get('POSTGRES_USER', ''),
            'PASSWORD': os.environ.get('POSTGRES_PASSWORD', ''),
            'HOST': os.environ.get('POSTGRES_HOST', ''),
        }   
    }

That's all we need to change, we can now start our Docker compose application using the following command:

    docker-compose up -d

and to execute more commands (e.g. DB migrations) on the running instance:

    docker-compose exec web ./apps/manage.py migrate 
    docker-compose exec web ./apps/manage.py createsuperuser

Note: dockerdjango is the name of the directory we are running the command from, you can use docker ps to find out your instances name too.
