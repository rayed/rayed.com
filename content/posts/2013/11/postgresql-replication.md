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
<p>We will assume we have two servers:</p>
<ul>
<li>Master IP 192.168.100.51</li>
<li>Slave IP 192.168.100.52</li>
</ul>
<h3>MASTER</h3>
<p>Create replication user &#8220;repl&#8221;:</p>
<pre><code>sudo -u postgres createuser -P repl
sudo -u postgres psql
&gt; ALTER ROLE repl REPLICATION;
</code></pre>
<p>Allow &#8220;repl&#8221; user to connect from the slave:</p>
<pre><code>$ vi /etc/postgresql/9.1/main/pg_hba.conf
:
host    replication     repl            192.168.100.52/32        md5
</code></pre>
<p>Setup replication parameters:</p>
<pre><code>vi /etc/postgresql/9.1/main/postgresql.conf
:   
listen_addresses = '*'
wal_level = hot_standby
max_wal_senders = 1
wal_keep_segments = 5
:
</code></pre>
<p>Create a copy of the database and copy to the slave:</p>
<pre><code>service postgresql stop
cd /var/lib/postgresql/9.1
tar -czf main.tar.gz main/
service postgresql start
scp main.tar.gz rayed@slave:
</code></pre>
<h3>SALVE</h3>
<p>Restore data from master:</p>
<pre><code>service postgresql stop
cd /var/lib/postgresql/9.1
rm -rf main   # BE CAREFUL MAKE SURE YOU ARE IN SLAVE
tar -xzvf ~rayed/main.tar.gz
rm /var/lib/postgresql/9.1/main/postmaster.pid
</code></pre>
<p>Create <strong>recovery.conf</strong> file in <strong>data</strong> directory:</p>
<pre><code>vi /var/lib/postgresql/9.1/main/recovery.conf
:   
standby_mode = 'on'
primary_conninfo = 'host=192.168.100.51 port=5432 user=repl password=repl_password
:   
</code></pre>
<p>Edit <strong>postgresql.conf</strong>:</p>
<pre><code>vi /etc/postgresql/9.1/main/postgresql.conf
:
hot_standby = on
:
</code></pre>
<p>Start the slave server again, and check the log file</p>
<pre><code>service postgresql start
tail -f /var/log/postgresql/postgresql-9.1-main.log 
</code></pre>
<p>For more info:</p>
<ul>
<li><a href="http://www.postgresql.org/docs/9.1/static/warm-standby.html">Log-Shipping Standby Servers</a></li>
<li><a href="http://wiki.postgresql.org/wiki/Binary_Replication_Tutorial">Binary Replication Tutorial</a></li>
</ul>
