---
title: Accelerating Postgres connections with PgBouncer
author: Rayed
type: post
date: 2014-05-28T12:03:58+03:00
categories:
  - Uncategorized
tags:
  - linux
  - pool
  - postgres
  - postgresql
  - ubuntu
wordpress_id: 1610

---

<a href="https://wiki.postgresql.org/wiki/PgBouncer">PgBouncer</a> is a lightweight connection pooler for PostgreSQL, connection pooling makes Postgres connection much faster, which is important in Web applications.<!--more-->


Here I will explain the steps I used to configure it under Ubuntu 14.04 LTS.


**Step 1:** We would configure users allowed to connect to PgBouncer:

    $ sudo vi /etc/pgbouncer/userlist.txt
    "rayed"  "pgbouncer_password_for_rayed"


**Step 2:** We configure databases PgBouncer will pool for, and how PgBouncer will authenticate user:

    $ sudo vi /etc/pgbouncer/pgbouncer.ini
    :
    [databases]
    rayed = host=localhost user=rayed password=postgres_password_for_rayed
    :
    auth_type = md5
    ;auth_file = /8.0/main/global/pg_auth
    auth_file = /etc/pgbouncer/userlist.txt

The default value for "auth_type" is "trust" which means a "system" user "rayed" will be allowed to connect to "Postgres" user "rayed", I change to "md5" to force a password checking from the file "/etc/pgbouncer/userlist.txt".


**Step 3:** We will allow PgBouncer to start:

    $ sudo vi /etc/default/pgbouncer 
    :
    START=1
    :

The default value is "0" which means don't start PgBouncer ever, it is a way to make sure you know what you are doing 🙂


**Step 4:** Starting pgBouncer:

    $ sudo service pgbouncer start


**Step 5:** Test the connection, by default "psql" connect using port "5432", and pgBouncer use "6432", so to test a pgBouncer connection we would use the following command:

    $ psql -p 6432 

If you get "Auth failed" error make, make sure the password you entered is the one you typed in step 1, if the command doesn't ask for password try it with "-W" option, e.g. "psql -p 6432 -W".

