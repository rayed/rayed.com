---
title: PostgreSQL on Ubuntu from scratch
author: Rayed
type: post
date: 2012-05-10T03:03:36+03:00
categories:
  - Uncategorized
tags:
  - linux
  - postgres
  - ubuntu
wordpress_id: 967

---
<img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Postgresql_elephant.svg/200px-Postgresql_elephant.svg.png" title="PostgreSQL" class="alignright" width="200" height="206" />

My notes on installing and configuring <a href="http://www.postgresql.org/">PostgreSQL</a> on Ubuntu Linux.

PostgreSQL is used by many large web sites and services, including Skype, Reddit, Instagram, ".org" registerer, check longer list here <a href="http://en.wikipedia.org/wiki/PostgreSQL#Prominent_users">Prominent Users</a>

Best of all it isn't owned by anyone, not Oracle nor anyone else!

<!--more-->



<li>
Installing PostgreSQL:

<pre>`$ sudo aptitude install postgresql`</pre>
</li>
<li>
If you want to allow access from outside, first you need to listen to all IP instead of "localhost" only:

<pre><code>$ sudo vi /etc/postgresql/8.4/main/postgresql.conf 
:
listen_addresses = '*'
:</code></pre>
and allow connecting:

<pre><code>$ sudo vi /etc/postgresql/8.4/main/pg_hba.conf 
:
host    all         all         10.0.0.0/24          md5
:</code></pre>
</li>
<li>You can start, stop, restart using the commands:
<pre>`$ sudo /etc/init.d/postgresql-8.4 stop`</pre>
</li>
<li>To connect as Postgres superuser, type:
<pre><code>$ sudo -u postgres psql
psql (8.4.11)
Type "help" for help.
postgres=#</code></pre>
Notice the "#" which means superuser, superuser can do anything!</li>
<li>From "psql" create a new database using:
<pre><code>postgres=# CREATE DATABASE rayed;
CREATE DATABASE
postgres=# \c rayed
psql (8.4.11)
You are now connected to database "rayed".
rayed=# </code></pre>
"\c" is used to switch database, notice the prompt changed to "rayed" the name of the database.</li>
<li>Let's create a new table:
<pre><code>rayed=# CREATE TABLE users (
"id" SERIAL,
"email" TEXT,
"firstname" TEXT,
"lastname" TEXT,
"password" TEXT,
PRIMARY KEY ("id")
);</code></pre>
"SERIAL" is a short cut, it will create a database "sequence", read about it is important, and if you are lazy it is an AUTO_INCREMENT field in MySQL. Let's see what we have created so far:

<pre><code>rayed=# \d
                List of relations
 Schema |       Name        |   Type   |  Owner   
--------+-------------------+----------+----------
 public | users             | table    | postgres
 public | users_user_id_seq | sequence | postgres
(2 rows)</code></pre>
Notice the auto created sequence, cool huh!
Try also: "\d+", "\d users", "\d+ users".</li>
<li>To see a list of databse on the system try "\l":
<pre><code>rayed=# \l
                                 List of databases
   Name    |  Owner   | Encoding | Collation  |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 rayed     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres
                                                           : postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres
                                                           : postgres=CTc/postgres
(4 rows)</code></pre>
You will notice we have 4 databases:



- postgres: This is where the schema for everything is stored, I think! NEED CHECKING
- rayed: the new database we created.
- template1: This an empty template database, whenever you create a new database it will be created from this one, you can even change this database to include any custom objects to be copied to new databases.
- template0: Another template DB, this one shouldn't be touched, it will be used to create new DB for restoring backups.


</li>
<li>We will create user named "rayed", and allow it to login:
<pre><code>rayed=# CREATE ROLE rayed LOGIN;
rayed=# \du
            List of roles
 Role name | Attributes  | Member of 
-----------+-------------+-----------
 postgres  | Superuser   | {}
           : Create role   
           : Create DB     
 rayed     |             | {}</code></pre>
Now I can login to "psql" directly from my account.
</li>
<li>User with a password:
`rayed=# ALTER ROLE rayed WITH PASSWORD 'my_pass_word';`
Now if you try to login from bash:

<pre>`$ psql `</pre>
Didn't ask for a password!!! This because we set "pg_hba.conf" to use "ident" service and not passwords for local connections, to fix this we add:

<pre><code>$ sudo vi /etc/postgresql/8.4/main/pg_hba.conf
:
local   all         postgres                          ident
local   all         all                               md5
:
$ sudo /etc/init.d/postgresql-8.4 restart
$ psql
Password for user rayed:</code></pre>
The changes we made to "pg_hba.conf" as follow, "postgres" is authenticated using "ident" service, other users should use "md5" password, order of the lines are important!
</li>
<li>Let's try to insert data to our "users" table:
<pre><code>rayed=> INSERT INTO users (email) VALUES('rayed@rayed.com');
ERROR:  permission denied for relation users</code>
Permission is denied because we created the database "rayed" and the table "users" from "postgres" account, and by default the creator will be the owner, we need to change the owner, from superuser (i.e. postgres) type:
<code>rayed=# ALTER TABLE users OWNER TO rayed;
ALTER TABLE
rayed=# ALTER SEQUENCE users_user_id_seq OWNER TO rayed;
ALTER SEQUENCE</code></pre>
Try inserting again, voila!
</li>
<li>Connecting from PHP now, try the example from <a href="http://www.php.net/manual/en/pgsql.examples-basic.php">http://www.php.net/manual/en/pgsql.examples-basic.php</a>, make sure you install PHP PostgreSQL module:
<pre>` $ sudo aptitude install php5-pgsql`</pre>
Make sure you change the database name, username, and password.
</li>


