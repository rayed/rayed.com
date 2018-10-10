---
title: 'Django with Docker: Build an Image'
author: Rayed
type: post
date: 2018-01-24T19:34:23+03:00
categories:
  - Uncategorized
tags:
  - django
  - docker
  - linux
  - python
wordpress_id: 2092

---

Docker is an interesting technology, although still young it gained a lot of buzz and momentum.

The last couple of weeks I started playing with Docker to see how can I use it for Django project development and deployment.
<!--more-->

## Bootstrap Django

The main idea of bootstraping a Django project using Docker is to avoid installing any software other than Docker on your development machine, so no need for Linux virtual machine or Python!

So we will start with an generic Python container image and install what we need and test it before building our own custom image.

    mkdir docker-django && cd docker-django
    docker run --rm -it  -v $PWD:/app -p 8000:8000 python:3.6 bash
    # --rm         # Remove container after finishing bootstrapping
    # -it          # Interactive Mode
    # -v $PWD:/app # Mount current directory to /app
    # -p 8000:8000 # Expose port 8000 as 8000
    cd /app
    pip install django
    pip freeze > requirements.txt
    django-admin startproject apps
    sed -i.bak 's/^ALLOWED_HOSTS.*/ALLOWED_HOSTS = ["*"]/' apps/apps/settings.py 
    ./apps/manage.py runserver 0.0.0.0:8000

By mounting the current directory to /app (`-v $PWD:/app`) we insure that all the files we generate inside the container will be stored outside it, so we can use it when we build our own custom conatiner.

We also exposed port 8000 (`-p 8000:8000`) so we can access our Django app from the development machine.

## Custom Image

Now that we have our `requirements.txt` file and our Django app directory `apps`, we can build our own custom image.

We start with our `Dockerfile`:

    FROM python:3.6
    ENV PYTHONUNBUFFERED 1
    COPY . /app
    WORKDIR /app
    RUN pip install -r requirements.txt
    EXPOSE 8000
    CMD ["python", "./apps/manage.py", "runserver", "0.0.0.0:8000"]

Then we build the image using the command:

    docker build -t my-dj-image .

and that's it we can start our new container using the following command:

    docker run --name my-dj-container --rm -p 8000:8000 my-dj-image

We give the new instance a name `my-dj-container` container so we can access it by name later instead of trying to find its ID.

Here are some other commands that I found useful for your container:

    # Mount /app to current directory to change the code
    docker run --name my-dj-container --rm -p 8000:8000 -v $PWD:/app my-dj-image
    
    # -d Detach, i.e. run in the background
    docker run --name my-dj-container --rm -p 8000:8000 -v $PWD:/app -d my-dj-image .
    
    # Run an extra commands on a running instance 'my-dj-container'
    docker exec -it my-dj-container /app/apps/manage.py migrate
    docker exec -it my-dj-container /app/apps/manage.py createsuperuser

