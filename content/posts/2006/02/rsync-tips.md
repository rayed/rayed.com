---
title: rsync tips
author: Rayed
type: post
date: 2006-02-23T12:28:42+03:00
categories:
  - alriyadh.com
  - UNIX
wordpress_id: 210

---
<p><a href="http://rsync.samba.org/">rsync</a> is a really smart file transfer tool, when you want to move a large directory from machine to machine it is the best tool you can use.</p>
<p>The tool utilise ssh protocol (among others) to transfer files, this is a sample command:</p>
<pre><code>host_1# rsync /some/dir host_2:/other</code></pre>
<p>The above command will copy the directory /some/dir  from host_1 to host_2, the smart thing about rsync that it check what files are already copied so it won&#8217;t copy them again.</p>
<p>Of course when migrating all your data from machine to machine it could take hours to finish, so the best thing to do is to start rsync like this:</p>
<pre><code>host_1# nohup rsync /some/dir host_2:/other &lt; /dev/null &</code></pre>
<p>nohup will keep rsync running even when your session with the server end, the other part &#8220;< /dev/null &#038;" will allow you to continue working on the session without waiting for rsync to end.

The output of rsync command will be redirected to a file called "nohup.out", of course nohup can be used with any command not just rsync.
</p>
