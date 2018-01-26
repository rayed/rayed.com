---
title: Caching method compared
author: Rayed
type: post
date: 2005-08-07T22:30:19+03:00
categories:
  - alriyadh.com
  - MySQL
  - PHP
  - UNIX
wordpress_id: 137

---
<p>I tested different types of caching, here is my times:</p>
<table border="1">
<tr>
<th>Method</th>
<th>Hit Time</th>
<th>Improvments over Miss</th>
</tr>
<tr>
<td>File</td>
<td>0.00029</td>
<td>19337.93%</td>
</tr>
<tr>
<td>MySQL</td>
<td>0.00064</td>
<td>8762.50%</td>
</tr>
<tr>
<td>memcached</td>
<td>0.00103</td>
<td>5444.66%</td>
</tr>
</table>
<p>Altought File caching is much faster that the other two methods, it can suffer from file locking problems, and can&#8217;t be shared between more than one server.</p>
<p>memcached client used is written in PHP which will slow it down a little bit.</p>
<p>So MySQL seems the ideal choice 😉</p>
