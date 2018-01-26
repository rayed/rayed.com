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

If you have a long running job that leaks few bytes of memory it will eventually will consume all of your memory with time.<!--more-->


Of course you need to find out where is the memory leak and fix it, but sometimes you can't because it on a code that you use and not your own code.


Apache webserver solve this problem by using `MaxRequestsPerChild` directive, which tells Apache worker process to die after serving a specified number of requests (e.g. 1000), which will free all the memory the process acquired during operation.


I had a similar problem with Django under Gunicorn, my Gunicorn workers memory keep growing and growing, to solve it I used Gunicorn option `-max-requests`, which works the same as Apache's `MaxRequestsPerChild`:

    gunicorn apps.wsgi:application -b 127.0.0.1:8080 --workers 8 --max-requests 1000
