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
<p>I was playing with <a href="https://www.djangoproject.com/">Django</a> with <a href="http://www.postgresql.org/">Postgres</a> backend, and I had little difficulty installing &#8220;<a href="http://initd.org/psycopg/">psycopg2</a>&#8221; the Python DB adapter for Postgres on my Mac OSX.</p>
<p>I&#8217;ve installed Postgres using <a href="http://postgresapp.com/">Postgres.app</a> for OSX which is straight forward and standard Mac app.</p>
<p>But when I tried installing &#8220;psycopg2&#8221; using &#8220;pip&#8221; (the python package manager) I got an error:<br />
<code></p>
<pre>$ pip install psycopg2
:
Error: pg_config executable not found.
:
</pre>
<p></code></p>
<p>I just searched for &#8220;pg_config&#8221; in my system:<br />
<code></p>
<pre>$ find / -name pg_config  2>/dev/null
/Applications/Postgres.app/Contents/Versions/9.3/bin/pg_config
</pre>
<p></code></p>
<p>Then added to my PATH env and pip worked:<br />
<code></p>
<pre>$ export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin/
$ pip install psycopg2
</pre>
<p></code></p>
