---
title: Tip on installing graphic support for PHP in FreeBSD
author: Rayed
type: post
date: 2005-08-19T16:10:54+03:00
categories:
  - PHP
  - UNIX
wordpress_id: 140

---
<p>GD is a graphic library that enable PHP to manipulate images, to install it from FreeBSD port us:</p>
<pre>
# cd /usr/ports/graphics/php4-gd
# make -DWITHOUT_X11 install
</pre>
<p>The tip is to use <tt>WITHOUT_X11</tt> option this will save you from compiling X Windows which is needed for some of GD supported formats.</p>
