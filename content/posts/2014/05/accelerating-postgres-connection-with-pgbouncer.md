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
<p><a href="https://wiki.postgresql.org/wiki/PgBouncer">PgBouncer</a> is a lightweight connection pooler for PostgreSQL, connection pooling makes Postgres connection much faster, which is important in Web applications.</p>
<p>Here I will explain the steps I used to configure it under Ubuntu 14.04 LTS.</p>
<p><strong>Step 1:</strong> We would configure users allowed to connect to PgBouncer:<br />
<code></p>
<pre>
$ sudo vi /etc/pgbouncer/userlist.txt
"rayed"  "pgbouncer_password_for_rayed"
</pre>
<p></code></p>
<p><strong>Step 2:</strong> We configure databases PgBouncer will pool for, and how PgBouncer will authenticate user:<br />
<code></p>
<pre>
$ sudo vi /etc/pgbouncer/pgbouncer.ini
:
[databases]
rayed = host=localhost user=rayed password=postgres_password_for_rayed
:
auth_type = md5
;auth_file = /8.0/main/global/pg_auth
auth_file = /etc/pgbouncer/userlist.txt
</pre>
<p></code><br />
The default value for &#8220;auth_type&#8221; is &#8220;trust&#8221; which means a <i>system</i> user &#8220;rayed&#8221; will be allowed to connect to <i>Postgres</i> user &#8220;rayed&#8221;, I change to &#8220;md5&#8221; to force a password checking from the file &#8220;/etc/pgbouncer/userlist.txt&#8221;.</p>
<p><strong>Step 3:</strong> We will allow PgBouncer to start:<br />
<code></p>
<pre>
$ sudo vi /etc/default/pgbouncer 
:
START=1
:
</pre>
<p></code><br />
The default value is &#8220;0&#8221; which means don&#8217;t start PgBouncer ever, it is a way to make sure you know what you are doing 🙂</p>
<p><strong>Step 4:</strong> Starting pgBouncer:<br />
<code></p>
<pre>
$ sudo service pgbouncer start
</pre>
<p></code></p>
<p><strong>Step 5:</strong> Test the connection, by default &#8220;psql&#8221; connect using port &#8220;5432&#8221;, and pgBouncer use &#8220;6432&#8221;, so to test a pgBouncer connection we would use the following command:<br />
<code></p>
<pre>
$ psql -p 6432 
</pre>
<p></code><br />
If you get &#8220;Auth failed&#8221; error make, make sure the password you entered is the one you typed in step 1, if the command doesn&#8217;t ask for password try it with &#8220;-W&#8221; option, e.g. &#8220;psql -p 6432 -W&#8221;.</p>
