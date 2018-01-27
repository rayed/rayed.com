---
title: PostgreSQL on windows
author: Rayed
type: post
date: 2005-11-12T15:00:19+03:00
categories:
  - UNIX
tags:
  - postgres
wordpress_id: 166

---
Last weekend I decided to try PostgreSQL on Windows, I download PostgreSQL 8.1 installation file from <a href="http://postgresql.org/">PostgreSQL website</a>, it was 22Mg zip file.

I also downloaded the 12 Mg manual, which contains everything about Postgres.

The installation is straight forward, simple wizard with some clicks and everything is installed and Postgres is running.

<a href="/static/uploads/old/20051112pgadmin.png"><img src='/static/uploads/old/thumb-20051112pgadmin.png' align="right" alt='' /></a>

Postgres comes with two clients:

- psql: CLI (command line) client.
- pgAdminIII: graphical client.


pgAdmin (see the screen shot) looks amazing and gives you access to all parts of the database, and you can connect to multiple databases. I got intimidated at first when I saw all the options in pgAdminIII but after looking carefully at them it isn't that scary 🙂

I saw many similarities between PostgreSQL and Oracle database, mainly how they use sequences instead of auto increment fields. In both databases to create auto incrementing field, e.g. ID, you create a sequence object, then during ask the sequence to get new ID for you.

Both databases have schemas, functions, triggers, procedures, view, tablespaces, among other thing, which makes PostgreSQL an ideal tool to learn Oracle too.

