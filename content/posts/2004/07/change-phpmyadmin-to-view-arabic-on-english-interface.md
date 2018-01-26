---
title: Change PHPMyAdmin to view Arabic on English interface
author: Rayed
type: post
date: 2004-07-27T01:35:42+03:00
categories:
  - MySQL
  - Uncategorized
tags:
  - MySQL
wordpress_id: 52

---
<p>I love phpmyadmin, it is a web interface for MySQL DB server, I usually use the English interface, but the problem with English interface that it doesn&#8217;t show Arabic string, of course you can change the whole interface to Arabic, but I don&#8217;t understand anything from that interface.</p>
<p>So I played with PHPMyAdmin code so I can use English interface but using Arabic character set, here is how to do it:<br />
<code><br />
# vi lang/english-iso-8859-1.inc.php<br />
... change: $charset = 'iso-8859-1';<br />
... to: $charset = 'windows-1256';<br />
</code></p>
<p><strong>UPDATE:</strong> PHPMyAdmin can show Arabic fine without problem even with English interface, if you have problem with Arabic it is a misconfiguration in your database, check this post for the proper way to handle Arabic in MySQL: <a href="http://rayed.com/wordpress/?p=324">MySQL: fixing errors of the past</a></p>
