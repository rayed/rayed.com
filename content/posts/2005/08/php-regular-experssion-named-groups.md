---
title: 'PHP & regular experssion named groups'
author: Rayed
type: post
date: 2005-08-26T20:04:11+03:00
categories:
  - PHP
wordpress_id: 143

---
<p>This is a nice regular expression feature, sometime when you have complex regular expression, you could forget what each refer to:<br />
<code><br />
$str = '2005-08-01';<br />
preg_match('/(\d{4})-(\d{1,2})-(\d{1,2})/', $str, $m);<br />
</code><br />
Now you don&#8217;t know which group is which part in the regular experssion.</p>
<p>Instead you can name all groups by using the format <tt>(?P&lt;name&gt;pattern)</tt> instead of just <tt>(pattern)</tt>, then you can access this group by name you assigned it, so the previous regular experssion could be written like:<br />
<code><br />
preg_match('/(?P&lt;year&gt;\d{4})-(?P&lt;month&gt;\d{1,2})-(?P&lt;day&gt;\d{1,2})/', $str, $m);<br />
</code></p>
