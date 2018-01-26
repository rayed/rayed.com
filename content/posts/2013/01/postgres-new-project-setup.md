---
title: 'PostgreSQL: New Project Setup'
author: Rayed
type: post
date: 2013-01-23T14:36:08+03:00
categories:
  - Uncategorized
tags:
  - postgres
  - postgresql
  - ubuntu
wordpress_id: 1083

---
<img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Postgresql_elephant.svg/200px-Postgresql_elephant.svg.png" title="PostgreSQL" class="alignright" width="200" height="206" /> For each new project that need <a href="http://www.postgresql.org/">PostgreSQL</a> you should create its own user and its own DB, the following are the steps need for that.



### Installation

    $ sudo aptitude install postgresql
    $ sudo aptitude install python-psycopg2  # For Django access


### Require a Password

    $ sudo vi /etc/postgresql/9.1/main/pg_hba.conf
    :
    #local   all             all                      peer
    local    all             all                      md5
    :
    $ sudo service postgresql restart    


### Create Postgres User

    $ sudo -u postgres createuser -P my_user
    Enter password for new role: 
    Enter it again: 
    Shall the new role be a superuser? (y/n) n
    Shall the new role be allowed to create databases? (y/n) n
    Shall the new role be allowed to create more new roles? (y/n) n


### Create DB

    $ sudo -u postgres createdb my_db -O my_user


### Test It

    $ psql -U my_user my_db   
After login you issue any SQL statement, you should also try the following commands:

- `\d` list tables.
- `\l` list databases.
- `\du` list users.


