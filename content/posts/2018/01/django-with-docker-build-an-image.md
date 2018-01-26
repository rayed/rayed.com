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

## Bootstrap Django

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


## Custom Image

    cat  <<EOF > Dockerfile
    FROM python:3.6-alpine
    COPY . /app
    WORKDIR /app
    RUN pip install -r requirements.txt
    EXPOSE 8000
    CMD ["python", "./apps/manage.py", "runserver", "0.0.0.0:8000"]
    EOF

    docker build -t my-dj-image .
    docker run --name my-dj-container --rm -p 8000:8000 my-dj-image
    docker run --name my-dj-container --rm -p 8000:8000 -v $PWD:/app my-dj-image   # You can update your code
    docker run --name my-dj-container --rm -p 8000:8000 -v $PWD:/app -d my-dj-image .  # -d Detach
    docker exec -it my-dj-container /app/apps/manage.py migrate
    docker exec -it my-dj-container /app/apps/manage.py createsuperuser

