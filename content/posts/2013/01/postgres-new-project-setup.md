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
<p><img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Postgresql_elephant.svg/200px-Postgresql_elephant.svg.png" title="PostgreSQL" class="alignright" width="200" height="206" /> For each new project that need <a href="http://www.postgresql.org/">PostgreSQL</a> you should create its own user and its own DB, the following are the steps need for that.</p>
<h2>Installation</h2>
<pre><code>$ sudo aptitude install postgresql
$ sudo aptitude install python-psycopg2  # For Django access
</code></pre>
<h2>Require a Password</h2>
<pre><code>$ sudo vi /etc/postgresql/9.1/main/pg_hba.conf
:
#local   all             all                      peer
local    all             all                      md5
:
$ sudo service postgresql restart    
</code></pre>
<h2>Create Postgres User</h2>
<pre><code>$ sudo -u postgres createuser -P my_user
Enter password for new role: 
Enter it again: 
Shall the new role be a superuser? (y/n) n
Shall the new role be allowed to create databases? (y/n) n
Shall the new role be allowed to create more new roles? (y/n) n
</code></pre>
<h2>Create DB</h2>
<pre><code>$ sudo -u postgres createdb my_db -O my_user
</code></pre>
<h2>Test It</h2>
<pre><code>$ psql -U my_user my_db   
</code></pre>
<p>After login you issue any SQL statement, you should also try the following commands:</p>
<ul>
<li><code>\d</code> list tables.</li>
<li><code>\l</code> list databases.</li>
<li><code>\du</code> list users.</li>
</ul>
