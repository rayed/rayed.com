---
title: PostgreSQL and PHP (on Windows)
author: Rayed
type: post
date: 2005-11-13T10:12:35+03:00
categories:
  - MySQL
  - PHP
  - UNIX
tags:
  - PHP
  - postgres
wordpress_id: 167

---
<p>After installing PostgreSQL (15 minutes job), and playing with pgAdminIII, I decided to try it with PHP.<br />
<!--more--><br />
I downloaded <a href="http://httpd.apache.org/">Apache 2</a> and installed it, simple wizard and it up and running.</p>
<p><a href="http://www.php.net/">PHP</a> was bit harder:</p>
<ul>
<li>I downloaded the PHP4 zip package, it was 8Mg download. Don&#8217;t download the installer version, it had limited functionality.</li>
<li>Unzip it under &#8220;C:\php&#8221;</li>
<li>Move all files under &#8220;sapi&#8221;, and &#8220;dlls&#8221;, to &#8220;C:\php&#8221;.</li>
<li>Copy &#8220;php.ini-dist&#8221; to &#8220;php.ini&#8221;</li>
<li>Edit &#8220;php.ini&#8221; and change the following:<br />
<code><br />
extension_dir = "c:\php\extensions\"<br />
extension=php_pgsql.dll<br />
</code>
</li>
<li>Add these lines to Apache configuration file (Start>Apache&#8230;>Configure..>Edit..)<br />
<code><br />
LoadModule php4_module "c:/php/php4apache2.dll"<br />
AddType application/x-httpd-php .php<br />
PHPIniDir "C:/php"<br />
</code>
</li>
<li>Restart Apache</li>
</ul>
<p>After that I tested it with simple file &#8220;phpinfo.php&#8221;:<br />
<code><br />
< ?php phpinfo(); ?><br />
</code></p>
<p>This file should display information about your PHP installaion, make sure &#8220;postgreSQL&#8221; support is enabled, search for &#8220;pgsql&#8221;.</p>
<p>Fortunately I always use <a href="http://adodb.sourceforge.net/">ADOdb</a> for PHP data access, so I didn&#8217;t need to learn Postgres system calls, I just got sample code from MySQL, and changed thhe connection string:<br />
<code><br />
&lt;?php<br />
 include("adodb/adodb.inc.php");<br />
 $db = NewADOConnection('postgres');<br />
 $db->Connect("localhost", "user", "******", "database");<br />
 $result = $db->GetAll("SELECT * FROM articles");<br />
 if($result===false) die('DB Error:'.$db->ErrorMsg());<br />
 print_r($result);<br />
?&gt;<br />
</code><br />
and it worked!!</p>
<p>Pretty easy may be I should play more with PostgreSQL.</p>
