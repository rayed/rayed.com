---
title: PostgreSQL Replication
author: Rayed
type: post
date: 2013-11-23T02:03:19+03:00
categories:
  - Uncategorized
tags:
  - linux
  - postgres
  - postgresql
  - ubuntu
wordpress_id: 1461

---

Setting up a Postgres replaication<!--more-->

We will assume we have two servers:

- Master IP 192.168.100.51
- Slave IP 192.168.100.52


### MASTER

Create replication user "repl":

    sudo -u postgres createuser -P repl
    sudo -u postgres psql
    > ALTER ROLE repl REPLICATION;

Allow "repl" user to connect from the slave:

    $ vi /etc/postgresql/9.1/main/pg_hba.conf
    :
    host    replication     repl            192.168.100.52/32        md5

Setup replication parameters:

    vi /etc/postgresql/9.1/main/postgresql.conf
    :   
    listen_addresses = '*'
    wal_level = hot_standby
    max_wal_senders = 1
    wal_keep_segments = 5
    :

Create a copy of the database and copy to the slave:

    service postgresql stop
    cd /var/lib/postgresql/9.1
    tar -czf main.tar.gz main/
    service postgresql start
    scp main.tar.gz rayed@slave:


### SALVE

Restore data from master:

    service postgresql stop
    cd /var/lib/postgresql/9.1
    rm -rf main   # BE CAREFUL MAKE SURE YOU ARE IN SLAVE
    tar -xzvf ~rayed/main.tar.gz
    rm /var/lib/postgresql/9.1/main/postmaster.pid

Create `recovery.conf` file in `data` directory:

    vi /var/lib/postgresql/9.1/main/recovery.conf
    :   
    standby_mode = 'on'
    primary_conninfo = 'host=192.168.100.51 port=5432 user=repl password=repl_password
    :   

Edit `postgresql.conf`:

    vi /etc/postgresql/9.1/main/postgresql.conf
    :
    hot_standby = on
    :

Start the slave server again, and check the log file

    service postgresql start
    tail -f /var/log/postgresql/postgresql-9.1-main.log 

For more info:

- <a href="http://www.postgresql.org/docs/9.1/static/warm-standby.html">Log-Shipping Standby Servers</a></li>
- <a href="http://wiki.postgresql.org/wiki/Binary_Replication_Tutorial">Binary Replication Tutorial</a>
