---
title: no-www
author: Rayed
type: post
date: 2005-07-11T21:04:32+03:00
categories:
  - UNIX
wordpress_id: 126

---
<p>I removed www from my site name, so from now on it is only <a href='http://rayed.com/' >http://rayed.com/</a>, www.rayed.com will be still acceptable but will be redirect to rayed.com.<br />
Here is how it is done in Apache:</p>
<pre>
&lt;VirtualHost *&gt;
        ServerName www.rayed.com
         Redirect permanent / http://rayed.com/
&lt;/VirtualHost&gt;
</pre>
