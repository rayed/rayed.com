---
title: Update Linux without a password
author: Rayed
type: post
date: 2013-03-20T09:15:27+03:00
categories:
  - Uncategorized
tags:
  - linux
  - sudo
  - ubuntu
wordpress_id: 1130

---
<p>So you managed to login to your Ubuntu Linux machine with a password by using the magic of ssh keys, and you installed &#8220;apticron&#8221; to email you whenever their is a system update, you login to the system and issue the update command &#8220;sudo aptitude update&#8221; and &#8220;sudo&#8221; asks you about your password! not only it is annoying, it also can&#8217;t be automated, imaging you manage 10 servers and you have to type the password to update each machine! or you want to automate using some remote execution application like <a href="http://docs.fabfile.org/">Fabric</a> or <a href="http://www.saltstack.com/">Salt</a> <small>(I am Python fan, so I won&#8217;t mention Chef or Puppet here)</small>.</p>
<p>The solution is very simple and most likely you already know it &#8220;sudo&#8221;, &#8220;sudo&#8221; can be configured not to ask for password for given command very easily:</p>
<pre>
$ sudo visudo
:
# Add the following lines
Cmnd_Alias APTITUDE = /usr/bin/aptitude update, /usr/bin/aptitude upgrade
rayed ALL=(ALL) NOPASSWD: APTITUDE
:
</pre>
<p>Now you can issue update commands with the need for password:</p>
<pre>
$ sudo aptitude update
$ sudo aptitude upgrade -y
</pre>
<p>The previous snippet are for &#8220;Ubuntu&#8221; systems, for &#8220;Red Hat&#8221; and &#8220;CentOS&#8221; you have to change the commands &#8220;aptitude update/upgrade&#8221; with &#8220;yum update&#8221;. </p>
