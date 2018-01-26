---
title: 'Lighttpd powers Saudi Arabia most <del>popular</del> unpopular website'
author: Rayed
type: post
date: 2007-01-16T23:12:34+03:00
categories:
  - SAUDI NET
  - UNIX
wordpress_id: 288

---
<p>Since we migrated Saudi Arabia international lines from <a href="http://www.isu.net.sa/">ISU</a> to <a href="http://www.stc.com.sa/">us</a>, we started to host the most unpopular web page in the kingdom, <a href="http://blocked.igw.net.sa/">Internet Block Page</a>.<br />
We started hosting it on Apache web server, but we noticed timeout problems with the server, to discover that slow clients reserve many Apache process which lead to consuming all of Apache processes.<br />
<a href="http://www.lighttpd.net/">Lighttpd</a> came to the rescue, I replaced Apache with Lighttpd and so far it is doing a great job. Lighttpd is a prefect fit since the website only serve one static page, and this where Lighttpd shines.<br />
This doesn&#8217;t mean Lighttpd is better than Apache, each one has its own uses, this small comparison table for both:</p>
<table>
<tr>
<th>Apache</th>
<th>Lighttpd</th>
</tr>
<tr>
<td>Prefrok</td>
<td>select</td>
</tr>
<tr>
<td>Dynamic (PHPm, Perl, CGI)</td>
<td>Static (html, gif,jpg)</td>
</tr>
<tr>
<td>CPU bound</td>
<td>I/O bound</td>
</tr>
<tr>
<td>Very flexible</td>
<td>Flexible enough 🙂</td>
</tr>
</table>
