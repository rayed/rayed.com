---
title: alriyadh.com moved to lighttpd
author: Rayed
type: post
date: 2007-02-04T09:23:03+03:00
categories:
  - alriyadh.com
  - PHP
  - UNIX
wordpress_id: 293

---
<p><a href="http://www.alriyadh.com/">Alriyadh.com</a> website is now served by <a href="http://www.lighttpd.net/">Lighttpd</a> (aka Lighty).</p>
<p>I moved all static content from <a href="http://httpd.apache.org/">Apache</a> to Lighty, Lighty &#8220;select&#8221; based design makes it ideal for I/O bound operation, i.e. disk and network operations. For this reason Lighty move all CPU bound operations to external process and communicate with them using FastCGI protocol.</p>
<p>This is what delayed my migration to Lighty, because I used to compile PHP with mod_php only and with FastCGI support, so I have to recompile PHP to enable it. Of course I spent few days testing, and I am still having some areas not covered completely.</p>
<p>Overall Lighty is a great software, and if you have highly loaded website, it is a must.</p>
