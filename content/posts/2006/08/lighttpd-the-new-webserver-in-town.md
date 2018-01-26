---
title: lighttpd the new webserver in town
author: Rayed
type: post
date: 2006-08-10T14:37:22+03:00
categories:
  - alriyadh.com
  - PHP
  - SAUDI NET
  - UNIX
wordpress_id: 255

---
<p>For the past 9 years I used <a href="http://httpd.apache.org/">Apache Web Server</a> exclusively, Apache is very stable and feature rich web server. The only downsize is consuming a lot of computer resources, Apache is a multi-processes server which mean you will find many Apache process running in your system and if we say that each process cosume 2MB of RAM and you have 5 Apache processes running this mean it needs 10MB of RAM.</p>
<p>Unfortunately the size of Apache process grows with each added module, e.g. if you have mod_php the size could reach 10MB. and if you have a busy system you could end up with 70 process consuming 700MB of your server RAM.</p>
<p><strong>Prefork vs Select based servers</strong></p>
<p>Apache uses a server programming method called preforking, preforking means it creates (or fork in UNIX) multiple processes in advance, and each process serve one client, and it create them in advance to improve performance.</p>
<p>Another way to build servers is using &#8220;select&#8221; function, in this kind of servers you use one process to serve all clients.</p>
<p><strong>Lighttpd</strong></p>
<p><a href="http://www.lighttpd.net/">Lighttpd</a> is select based web server, which menas one process for all clients. When comparing memory requirement for Apache and Lighttpd serving 50 clients:</p>
<ul>
<li>Apache: 10MB per process * 50 process = 500 MB</li>
<li>Lighttpd: 7MB * 1 process = 7 MB</li>
</ul>
<p>Let&#8217;s assume your client grow from 50 concourent to 200 process, Apache would need 2GB where Lighttpd will use the same amount of memory.</p>
<p><strong>Static vs Dynamic content</strong></p>
<p>Lighttpd is great for serving static content like images, audio files, movies, CSS, Javascript, or any conent served directly from a file. For dynamic content Lighttpd must relay these requests to another process like FastCGI server, I won&#8217;t dive into the details of dynamic content in Lighttpd because I don&#8217;t know a lot about it yet.</p>
