---
title: “Unfair” Apache performance comparison
author: Rayed
type: post
date: 2006-02-23T23:09:27+03:00
categories:
  - alriyadh.com
  - UNIX
wordpress_id: 212

---
<p>To find out how fast <a href="http://rayed.com/wordpress/?p=209">our new servers</a> are I run a small test using <a href="http://httpd.apache.org/docs/1.3/programs/ab.html">ab</a> Apache HTTP server benchmarking tool.<br />
I&#8217;ll send 10,000 requests using 10 simultaneous processes, I run the same test on both old and new server:<br />
<b>Old Server</b><br />
<code>$ ab -c 10 -n 10000 www.alriyadh.com/zzz.txt<br />
:<br />
Time taken for tests:   78.172 seconds<br />
:<br />
</code></p>
<p><b>New Server</b><br />
<code>$ ab -c 10 -n 10000 new-www.alriyadh.com/zzz.txt<br />
:<br />
Time taken for tests:   3.851 seconds<br />
:<br />
</code></p>
<p>This mean that the new server is <b>20</b> times faster than the old server, the test is really unfair because the old server is running on production and serving other requests. I&#8217;ll repeat the same test after migration to see the real numbers.</p>
<p><b>Update:</b> I repeated the test on the old server after migration, and the time taken dropped to 32.316 seconds.</p>
