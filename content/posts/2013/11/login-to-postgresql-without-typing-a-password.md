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
<p>If you to connect to PostgreSQL without typing a password, you can do it by having your password in the file &#8220;.pgpass&#8221;.</p>
<p>The file reside in your home directory and must be readable to you only:</p>
<pre><code>touch ~/.pgpass
chmod 600 ~/.pgpass
</code></pre>
<p>The format is simple:</p>
<pre><code>hostname:port:database:username:password 
</code></pre>
<p>For example:</p>
<pre><code>*:*:my_database:rayed:my_hard_password
</code></pre>
<p>The &#8220;*&#8221; means any host using any port.</p>
<p>This of course will work for &#8220;psql&#8221; and other tools to like &#8220;pg_dump&#8221;.</p>
