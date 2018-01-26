---
title: 'MySQL: fixing errors of the past'
author: Rayed
type: post
date: 2007-09-01T14:37:35+03:00
categories:
  - alriyadh.com
  - MySQL
wordpress_id: 324

---
<p>Old MySQL versions didn&#8217;t have good support for Arabic, so what I used to do is to configure MySQL tables with any character set e.g. latin-1 and configure PHP to read it and write in Windows-1256 and pass it to MySQL as is i.e. MySQL think it is &#8220;Latin-1&#8221; but in fact it is &#8220;Windows-1256&#8221;.</p>
<p>Needless to say cheating in the character set have many bad consensuses:</p>
<ul>
<li>Sorting will not work as expected</li>
<li>Other applications will assume you are using the correct character set and you won&#8217;t be able to read or write your data. e.g. PHPMyAdmin could display something like this:<br />
&#8220;ÈÓã Çááå ÇáÑÍãä ÇáÑÍíã&#8221;</li>
</ul>
<p><b>How to fix it</b><br />
I found this trick in MySQL documentation, what you need to do is convert any character field to &#8220;blob&#8221; then convert it back to the desired field type with the desired character set:<br />
<code><br />
ALTER TABLE t1 CHANGE c1 c1 BLOB;<br />
ALTER TABLE t1 CHANGE c1 c1 TEXT CHARACTER SET cp1256;<br />
</code><br />
You can change it and test it from phpMyAdmin.</p>
<p>Of course it would be wiser to automate the process using a php script.</p>
<p>If you want to store the data in UTF-8, you can convert it using the command:<br />
<code><br />
ALTER TABLE t1 CHANGE c1 c1 TEXT CHARACTER SET utf8;<br />
</code></p>
<p>NOTE: don&#8217;t convert from &#8220;blob&#8221; to &#8220;utf8&#8221; unless your data is actually stored using &#8220;utf8&#8221;.</p>
<p><b>Windows-1256 or UTF8</b><br />
If you are application use only Arabic and English you can store the data in Windows-1256 (aka CP1256), but if you want to store more character set you need to use UTF8.</p>
<p>Even if you use Windows-1256 to store your data in MySQL you can still build applications with UTF8 interface, this done by using the SQL command:<br />
<code><br />
SET NAMES utf8<br />
</code><br />
This command means all data communication between your application (PHP page) and the server is UTF8, MySQL server could store in Windows-1256 or UTF-8 it doesn&#8217;t really matter. Keep in mind storing Arabic data in UTF8 means double sizing your MySQL data files.</p>
<p><b>??????</b><br />
If you see your data in question mark like this &#8220;????? ?????? ????&#8221; it means your &#8220;MySQL connection&#8221; character set is incompatible with &#8220;MySQL storage&#8221; character set, and when MySQL doesn&#8217;t know how to convert any character it replaces it with &#8220;?&#8221;.</p>
<p><b>UPDATE</b>:<br />
A great way to migrate your application is to set the server default charset to &#8220;cp1256&#8221;, and set all new connections to use it:<br />
<code><br />
[mysqld]<br />
init-connect='SET NAMES cp1256'<br />
character_set_server=cp1256<br />
</code></p>
