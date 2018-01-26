---
title: 'WP1 & WP2 spam filtering'
author: Rayed
type: post
date: 2006-06-08T00:33:16+03:00
categories:
  - Blog
wordpress_id: 243

---
<p>While upgrading WordPress to version 2, I backed up my database and I noticed that the comments table size is around 1.7MB which is huge, I don&#8217;t have that many comments. I find out that WordPress don&#8217;t delete comments even if they were marked spam, so I deleted them manually, so go check your comments table and save some space.</p>
<p><strong>WP1 Spam detection:</strong><br />
WordPress 1.x has a feature that mark comments as spam if they match certin keywords, it was doing very good job, except for that last few weeks I start getting new spam comments so I had to update my spam keywods.</p>
<p><strong>WP2 Spam detection:</strong><br />
WordPress 2.x have a built-in plugin called Akismet, this plugin will check all comments posted to your blog by sending them to Akismet server which apporve the comment or mark it as spam, the good think about Akimet that you don&#8217;t have to update your spam filtering keywords every time the spammer changed their message.  Until now Akismet is doing a great job, it blocked more than 17 comments in less than 24 ours.</p>
<p><strong>Akismet proxy supprt:</strong><br />
Of course it doesn&#8217;t support proxy, so here is my patch, replace the these two sepeate lines:<br />
<code><br />
$http_request  = "POST $path HTTP/1.0\r\n";<br />
if( false !== ( $fs = @fsockopen($host, $port, $errno, $errstr, 10) ) ) {<br />
</code><br />
With these two:<br />
<code><br />
$http_request  = "POST http://$host/$path HTTP/1.0\r\n";<br />
if( false !== ( $fs = @fsockopen('proxy.saudi.net.sa', 8080, $errno, $errstr, 10) ) ) {<br />
</code></p>
