---
title: 'Django with Docker: Add Postgres'
author: Rayed
type: post
date: 2018-01-24T20:33:26+03:00
categories:
  - Uncategorized
wordpress_id: 2096

---
<p>sudo yum install -y docker-compose</p>
<p>Craete new docker-compose.yml<br />
<code></p>
<pre>
version: "3"
services:

  db:
    image: postgres
    restart: always
    environment:
      POSTGRES_DB: dj
      POSTGRES_USER: dj
      POSTGRES_PASSWORD: should_use_env
      PGDATA: /data
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
</pre>
<p></code></p>
<p>Add to requirements.txt<br />
<code></p>
<pre>
psycopg2==2.7.3.2
</pre>
<p></code></p>
<p>Change DATABASE section in apps/apps/settings.py:<br />
<code></p>
<pre>
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ.get('POSTGRES_DB', ''),
        'USER': os.environ.get('POSTGRES_USER', ''),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD', ''),
        'HOST': os.environ.get('POSTGRES_HOST', ''),
    }   
}
</pre>
<p></code></p>
<p><code></p>
<pre>
docker-compose up -d
docker exec -it dockerdjango_web_1 ./apps/manage.py migrate 
docker exec -it dockerdjango_web_1 ./apps/manage.py createsuperuser
</pre>
<p></code></p>
