---
title: Fixing WordPress dashboard
author: Rayed
type: post
date: 2005-06-27T12:27:00+03:00
categories:
  - Blog
wordpress_id: 113

---
<div style="clear:both;"></div>
<p>WordPress is a personal blogging software, works with PHP and MySQL.<br />The first page of WordPress administration page is called dash board it usually takes forever to load, this due the fact that WordPress display some RSS feed from its development blog.<br />The loading problem caused by trying to access the RSS feed with a proxy server, which won&#8217;t work inside Saudi Arabia, so here is the fix, in the file <b>wp-includes/class-snoopy.php</b> modify the proxy lines to be something like:<br /><code><br />var $proxy_host = "proxy.saudi.net.sa"; // proxy host to use<br />var $proxy_port = "8080";  // proxy port to use<br /></code></p>
<p>and the dashboard should load as expected.</p>
<div style="clear:both; padding-bottom: 0.25em;"></div>
