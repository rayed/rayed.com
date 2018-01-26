---
title: PHP output compression
author: Rayed
type: post
date: 2006-03-31T15:30:42+03:00
categories:
  - alriyadh.com
  - PHP
  - UNIX
wordpress_id: 222

---
<p>PHP 4.0.5 and above added new feature to compress your PHP pages on the fly, all you need is the zlib extension, this how I configured it.<br />
<code># vi /usr/local/etc/php.ini<br />
:<br />
zlib.output_compression = On<br />
:<br />
# apachectl graceful<br />
</code></p>
<p><a href="http://www.alriyadh.com/">Alriyadh.com</a> front page size dropped from 20.5 K to 5.6 K, according to my tests almost 50% of browser don&#8217;t support compression, IE for instance turn off gzip compression support if you have bad firewalls (Zone Alarm), and even some IE extensions (specially ad wares) turn off the compression.</p>
<p>I used to have compression support inside my caching library, but I guess I&#8217;ll turn it of in favour of PHP native support, the old cache saved around 40% of the website bandwidth, and of course this will make the appear much faster for the users.</p>
<p>I am not sure about the affect of the &#8220;on the fly&#8221; compression on the processor utilization, but with the new hardware I am not that worried.</p>
