---
title: CakePHP under Lighttpd
author: Rayed
type: post
date: 2007-02-09T23:28:06+03:00
categories:
  - alriyadh.com
  - PHP
  - UNIX
wordpress_id: 297

---
<p>After moving <a href="http://www.alriyadh.com/">alriyadh.com</a> to <a href="http://www.lighttpd.net/">Lighttpd</a> I had some problem making a <a href="http://cakephp.org/">CakePHP</a> application I wrote to work properly.</p>
<p>I searched the net for a solution and I found this <a href="http://bakery.cakephp.org/articles/view/164">post</a>, but unfortunately the solution they proposed didn&#8217;t work, I spent several hours trying to make it work until I gave up, I decide to do it from scratch and luckily it worked. </p>
<p>The mod_rewrite rules I used in lighttpd.conf file:<br />
<code><br />
url.rewrite-once = (<br />
        "^/cake/(css|files|img|js|stats)/(.*)$" => "/cake/app/webroot/$1/$2",<br />
        "^/cake/(.*)$" => "/cake/app/webroot/index.php?url=$1"<br />
)<br />
</code><br />
Where cake is you cakePHP application.</p>
<p>I tried to login and add a comment to the CakePHP Bakery site, but I got an error when I try to comment!</p>
