---
title: Cricket extensions
author: Rayed
type: post
date: 2006-08-10T15:13:24+03:00
categories:
  - alriyadh.com
  - SAUDI NET
  - UNIX
wordpress_id: 257

---
<p><strong>Cricket</strong></p>
<p><a href="http://cricket.sourceforge.net/">Cricket</a> is trend monitoring software, it allows you to monitor trend for any device you want.</p>
<p>I wrote 2 extensions for Cricket to monitor <a href="http://www.lighttpd.net/">Lighttpd</a> web server, and <a href="http://www.danga.com/memcached/">Memecached</a> caching server.</p>
<p><strong>Lighttpd web server</strong></p>
<p>&#8220;<em>lighttpd (also called &#8220;Lighty&#8221;) is a web server which is designed to be secure, fast, standards-compliant, and flexible while being optimized for speed-critical environments. Its low memory footprint (compared to other web servers), light CPU load and its speed goals make lighttpd suitable for servers that are suffering load problems, or for serving static media separately from dynamic content. lighttpd is free software / open source, and is distributed under the BSD license.</em>&#8221;  Wikipedia</p>
<p><img alt="Cricket lighttpd" src="/static/uploads/old/2006-08-10/lighttpd-hits-small.jpg" /></p>
<p>Features:</p>
<ul>
<li>Requests per</li>
<li>KByte per second</li>
<li>Busy servers</li>
<li>Download <a href="/static/uploads/old/2006-08-10/cricket-lighttpd.tar.gz">cricket-lighttpd.tar.gz</a></li>
</ul>
<p><strong>Memcached server</strong></p>
<p>&#8220;<em>memcached is a distributed memory caching system that was originally developed by Danga Interactive for LiveJournal. It is used to speed up dynamic database-driven websites by caching data and objects in memory to reduce the amount the database needs to be read. memcached is open source and released under a BSD license. It uses libevent.</em>&#8221; Wikipedia</p>
<p><img alt="Cricket Memcached" title="Cricket Memcached" src="/static/uploads/old/2006-08-10/memcached-hit-vs-miss-small.jpg" /></p>
<p>Features:</p>
<ul>
<li>Connects per seond</li>
<li>Requests per second</li>
<li>Hits and Misses</li>
<li>KByte per second</li>
<li>Bandwidth in and out</li>
<li>Download <a href="/static/uploads/old/2006-08-10/cricket-memcached.tar.gz">cricket-memcached.tar.gz</a></li>
</ul>
