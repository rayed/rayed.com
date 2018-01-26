---
title: Optimizing MySQL
author: Rayed
type: post
date: 2006-06-20T01:30:31+03:00
categories:
  - alriyadh.com
  - MySQL
  - PHP
  - UNIX
wordpress_id: 250

---
<p>The last 3 days we were facing many problems with <a href="http://www.alriyadh.com/">Alriyadh.com</a> web server, the server suddenly get very slow, and all requests times out. It took me very long time to identify the problem, I tried many things and every time I think it will solve the problem completely, but after few hours the problem appear again and he server start to crawl.<br />
Until this moment I am not 100% sure the problem is solved, but during the process I learned many things, so I&#8217;ll share it with you and hopefully everything will go smoothly, if it doesn&#8217;t I have to learn new thing to figure out the problem.</p>
<p>Lesson 1: Use the right tools to monitor your system, I usually use &#8220;top&#8221; command to see which process is using my CPU and memory, CPU and memory is not the only bottleneck in the server, until I used &#8220;systat -vmstat 1&#8221; command I didn&#8217;t know that I my bottleneck was in the hard disk and not the CPU or memory.</p>
<p>Lesson 2: Databases are usually I/O bound so poorly written query could easily kill your server I/O, I had a poorly written query that had to scan more than 160,000 records and after optimization it only scan 2000 records, another query needed an index to drop its execution time from 1.9 second to 0.35 second.</p>
<p>Lesson 3: Enable MySQL slow query logging, I configured MySQL so it will log any query taking more than 1 second to finish, this is done by adding these lines to &#8220;my.cnf&#8221;:<br />
<code><br />
set-variable = long_query_time=1<br />
log-slow-queries<br />
</code><br />
By doing this you can easily find the queries that need optimization, index, or caching!</p>
<p>Lesson 4: Use MySQL &#8220;EXPLAIN&#8221; command it will show you how MySQL going to execute the query, which indexes to use, and how many record it will scan. This way you can test your optimization technique and see if it really works.</p>
<p>Lesson 5: Cache slow queries, some queries are very complex and you can&#8217;t escape the fact that they will take long time, so the best thing to do is to cache the query result and reuse it.</p>
