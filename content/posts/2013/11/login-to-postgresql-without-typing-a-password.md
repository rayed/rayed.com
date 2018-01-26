---
title: Login to PostgreSQL without typing a Password
author: Rayed
type: post
date: 2013-11-21T15:12:06+03:00
categories:
  - Uncategorized
tags:
  - postgres
  - postgresql
wordpress_id: 1458

---

If you to connect to PostgreSQL without typing a password, you can do it by having your password in the file ".pgpass".<!--more-->


The file reside in your home directory and must be readable to you only:

    touch ~/.pgpass
    chmod 600 ~/.pgpass

The format is simple:

    hostname:port:database:username:password 

For example:

    *:*:my_database:rayed:my_hard_password

The "*" means any host using any port.

No try issuing a command like:

    psql -U rayed my_database

It will connect without asking about the password!

This of course will work for "psql" and other tools to like "pg_dump".

