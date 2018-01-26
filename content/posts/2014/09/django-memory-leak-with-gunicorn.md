---
title: Django memory leak with gunicorn
author: Rayed
type: post
date: 2014-09-29T18:57:09+03:00
categories:
  - Uncategorized
tags:
  - django
  - gunicorn
  - linux
wordpress_id: 1669

---
<p><strong>tl;dr</strong> add &#8220;&#8211;max-requests&#8221; to Gunicorn to easily solve memory leak problems.</p>
<p>If you have a long running job that leaks few bytes of memory it will eventually will consume all of your memory with time.</p>
<p>Of course you need to find out where is the memory leak and fix it, but sometimes you can&#8217;t because it on a code that you use and not your own code.</p>
<p>Apache webserver solve this problem by using &#8220;MaxRequestsPerChild&#8221; directive, which tells Apache worker process to die after serving a specified number of requests (e.g. 1000), which will free all the memory the process acquired during operation.</p>
<p>I had a similar problem with Django under Gunicorn, my Gunicorn workers memory keep growing and growing, to solve it I used Gunicorn option &#8220;&#8211;max-requests&#8221;, which works the same as Apache&#8217;s &#8220;MaxRequestsPerChild&#8221;:</p>
<pre><code>gunicorn apps.wsgi:application -b 127.0.0.1:8080 --workers 8 --max-requests 1000
</code></pre>
