---
title: Alriyadh.com ads server migrated to FreeBSD
author: Rayed
type: post
date: 2006-03-13T15:55:04+03:00
categories:
  - alriyadh.com
  - UNIX
wordpress_id: 216

---
<p>The ads appear now as if they are local images, awesome 🙂</p>
<p><a href="/upload/2006-03-15/cpu.png"><img src="/upload/2006-03-15/cpu-small.png" border="0" /></a></p>
<p>You will notice that the maximum CPU utlization is 29% at around 7:30 am, at this time the old server would hit 100% CPU utlization.</p>
<p>The 29% is before enabling <a href="http://pecl.php.net/package/APC">APC</a> (Alternative PHP Cache) which replaced PHPAccelerator I used with the old server, you can see a major drop in CPU utilization after enabling it.</p>
