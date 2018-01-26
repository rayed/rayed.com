---
title: Install psycopg2 (PostgreSQL adapter for Python) on OSX
author: Rayed
type: post
date: 2014-12-31T15:18:20+03:00
categories:
  - Uncategorized
tags:
  - osx
  - pip
  - postgres
  - python
wordpress_id: 1743

---
I was playing with <a href="https://www.djangoproject.com/">Django</a> with <a href="http://www.postgresql.org/">Postgres</a> backend, and I had little difficulty installing "<a href="http://initd.org/psycopg/">psycopg2</a>" the Python DB adapter for Postgres on my Mac OSX.

I've installed Postgres using <a href="http://postgresapp.com/">Postgres.app</a> for OSX which is straight forward and standard Mac app.

But when I tried installing "psycopg2" using "pip" (the python package manager) I got an error:

    $ pip install psycopg2
    :
    Error: pg_config executable not found.
    :

I just searched for "pg_config" in my system:

    $ find / -name pg_config  2>/dev/null
    /Applications/Postgres.app/Contents/Versions/9.3/bin/pg_config

Then added to my PATH env and pip worked:

    $ export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin/
    $ pip install psycopg2
