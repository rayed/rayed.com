---
title: 'Caching: memcached vs MySQL'
author: Rayed
type: post
date: 2006-03-30T23:46:27+03:00
categories:
  - alriyadh.com
  - MySQL
  - PHP
  - UNIX
wordpress_id: 221

---
<p>Several month ago I researched caching methods to use with <a href="http://www.alriyadh.com/">Alriyadh.com</a>, it was essential because we used old and slow hardware.<br />
The result of <a href="http://rayed.com/wordpress/?p=137">my test</a> showed that MySQL based caching was superior to <a href="http://www.danga.com/memcached/">memcached</a> caching.</p>
<p>I did a new benchmark comparing MySQL, <a href="http://pecl.php.net/package/memcache">PHP memcache extension</a>, and <a href="http://phpca.cytherianage.net/memcached/">PHP memcache class</a>.</p>
<p>The text is done by fetching the result of a complex query 1000 times, and calculated the time it took using my <a href="http://rayed.com/wordpress/?page_id=138">bechmark library</a>, times in seconds:</p>
<table border="1">
<tr>
<td>Data Size</td>
<td>11513</td>
</tr>
<tr>
<td>MySQL query no cache</td>
<td>9.16003489494</td>
</tr>
<tr>
<td>MySQL query with cache</td>
<td>0.545562982559</td>
</tr>
<tr>
<td>memcached extension</td>
<td>0.376034021378</td>
</tr>
<tr>
<td>memcached class</td>
<td>0.493839025497</td>
</tr>
</table>
<p>It seems that memcached is actually faster than MySQL caching, even when using memcache class. (In my old test, MySQL cache support only text caching, i.e. no serialize and unserialize)</p>
