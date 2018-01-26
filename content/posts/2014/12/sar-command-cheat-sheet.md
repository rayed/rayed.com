---
title: “sar” command cheat sheet
author: Rayed
type: post
date: 2014-12-11T13:43:08+03:00
categories:
  - Uncategorized
tags:
  - admin
  - linux
  - monitor
  - top
wordpress_id: 1718

---
<p>&#8220;sar&#8221; is a Unix command that collect, report, or save system activity information, it is different from other system status command like &#8220;top&#8221; or &#8220;vmstat&#8221; that only show real time status only, &#8220;sar&#8221; in the other hand collect these data so you can find the system state at any time.</p>
<h2>OPTIONS</h2>
<pre><code># Live values: interval count
sar 1 3

# historical values
sar
</code></pre>
<p><strong>Previous Days</strong></p>
<pre><code># Day 11 of current month Ubuntu
sar -f /var/log/sysstat/sa11

# Day 11 of current Month CentOS
sar -f /var/log/sa/sa11
</code></pre>
<p><strong>Time Range</strong></p>
<pre><code># show from 10:00 am to 11:00 am
sar -s 10:00:00 -e 11:00:00
</code></pre>
<p><strong>Data Options</strong></p>
<pre><code>sar      # CPU 
sar -r   # RAM
sar -b   # Disk
</code></pre>
<p><strong>Mixing options</strong></p>
<pre><code>sar   -b   -s 10:00:00 -e 11:00:00   -f /var/log/sa/sa11  
-b   # disk 
-s   # from 10:00 to 11:00
-f   # day 11
</code></pre>
<h2>Installation</h2>
<p><strong>CentOS</strong></p>
<pre><code>$ sudo yum install sysstat
</code></pre>
<p><strong>Ubuntu</strong></p>
<pre><code>$ sudo apt-get install sysstat
$ sudo vi /etc/default/sysstat
ENABLED=”true”
</code></pre>
<p>More info:<br />
<a href="http://www.linuxjournal.com/content/sysadmins-toolbox-sar">http://www.linuxjournal.com/content/sysadmins-toolbox-sar</a></p>
