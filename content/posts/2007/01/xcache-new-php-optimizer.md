---
title: XCache new PHP optimizer
author: Rayed
type: post
date: 2007-01-01T00:24:37+03:00
categories:
  - alriyadh.com
  - PHP
  - UNIX
wordpress_id: 281

---
<p><a href="http://trac.lighttpd.net/xcache/">XCache</a> is relatively new PHP code optimizer, written by &#8220;Jan Kneschke&#8221; the same guy who wrote <a href="http://www.lighttpd.net/">Lighttpd</a> web server.</p>
<p>After migrating <a href="http://www.alriyadh.com/">Alriyadh.com</a> to the new dual CPU servers, I had problems with APC PHP optimizer and locking, so I disabled the optimizer altogether, after all the CPU was very fast and it handled the load without any problems.</p>
<p>But lately with my increasing interest on Lighttpd I noticed XCache, I never heard of it before but after reading the web site, and the problem APC have with multi processors I decided to give XCache a try, and the best of all it was ready in <a href="http://www.freebsd.org/">FreeBSD</a> ports, so I installed it and so far it doing a good job.</p>
<p>My initial tests shows 400% improvement. Thanks Jan.</p>
<p><strong>Correction:</strong> &#8220;Jan Kneschke&#8221; left a comment correcting me about the developer of XCache, it was written by &#8220;mOo&#8221;. Thanks Jan for correcting me, the visit, and Lighty of course 🙂</p>
