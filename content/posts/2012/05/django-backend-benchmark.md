---
title: Django backend benchmark
author: Rayed
type: post
date: 2012-05-10T19:10:42+03:00
categories:
  - Uncategorized
tags:
  - benchmark
  - db
  - django
  - MySQL
  - postgres
wordpress_id: 952

---
I create small Django app and tried to benchmark it with different backends, here is the result:

<table>
<tr>
<th>Backend</th>
<th>Req/Sec</th>
</tr>
<tr>
<td>PostgreSQL</td>
<td>68.41</td>
</tr>
<tr>
<td>PostgreSQL+pgpool</td>
<td>116.12</td>
</tr>
<tr>
<td>MySQL</td>
<td>127.61</td>
</tr>
</table>
The test performed using "ab" tool, 1000 requests with 5 concurrent clients:
`$ ab -c 5 -n 1000 http://localhost/test`

