---
title: Fixing “cannot change locale (UTF-8)” error
author: Rayed
type: post
date: 2013-03-20T11:21:06+03:00
categories:
  - Uncategorized
tags:
  - linux
  - osx
  - ssh
wordpress_id: 1134

---
<p>I am trying new way to fix the annoying &#8220;cannot change locale (UTF-8)&#8221; error, this error usually show when you login from your OSX to a Linux machine:</p>
<pre>
osx$ ssh ubuntu-server
Last login: Sat Mar  9 09:04:40 2013 from 10.10.12.16
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8)
[rayed@ubuntu-server ~]$
</pre>
<p>The problem happens because OSX send LC_CTYPE environment variable when you connect through ssh, the solution is to ask OSX not to send these variables. This can be done by editing you ssh config file on you OSX and commenting the &#8220;SendEnv&#8221; variable:</p>
<pre>    
osx$ sudo vi /etc/ssh_config
:
#SendEnv LANG LC_*
:
</pre>
