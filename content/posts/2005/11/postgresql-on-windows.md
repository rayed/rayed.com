---
title: PostgreSQL on windows
author: Rayed
type: post
date: 2005-11-12T15:00:19+03:00
categories:
  - UNIX
tags:
  - postgres
wordpress_id: 166

---
<p>Last weekend I decided to try PostgreSQL on Windows, I download PostgreSQL 8.1 installation file from <a href="http://postgresql.org/">PostgreSQL website</a>, it was 22Mg zip file.</p>
<p>I also downloaded the 12 Mg manual, which contains everything about Postgres.</p>
<p>The installation is straight forward, simple wizard with some clicks and everything is installed and Postgres is running.</p>
<p><a href="http://rayed.com/wordpress/wp-content/upload/20051112pgadmin.png"><img src='http://rayed.com/wordpress/wp-content/upload/thumb-20051112pgadmin.png' align="right" alt='' /></a></p>
<p>Postgres comes with two clients:</p>
<ul>
<li>psql: CLI (command line) client.</li>
<li>pgAdminIII: graphical client.</li>
</ul>
<p>pgAdmin (see the screen shot) looks amazing and gives you access to all parts of the database, and you can connect to multiple databases. I got intimidated at first when I saw all the options in pgAdminIII but after looking carefully at them it isn&#8217;t that scary 🙂</p>
<p>I saw many similarities between PostgreSQL and Oracle database, mainly how they use sequences instead of auto increment fields. In both databases to create auto incrementing field, e.g. ID, you create a sequence object, then during ask the sequence to get new ID for you.</p>
<p>Both databases have schemas, functions, triggers, procedures, view, tablespaces, among other thing, which makes PostgreSQL an ideal tool to learn Oracle too.</p>
