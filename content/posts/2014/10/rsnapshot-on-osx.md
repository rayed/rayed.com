---
title: Rsnapshot on OSX
author: Rayed
type: post
date: 2014-10-27T22:12:58+03:00
categories:
  - Uncategorized
tags:
  - backup
  - osx
  - rsnapshot
wordpress_id: 1693

---
<p>Rsnapshot is a backup solution for Unix machines including Linux and OSX, it supports many great features including full backups with the size of only incremental backup, it also support backing up local and remote machines.</p>
<p>Check my previous post for more details about it, <a href="http://rayed.com/wordpress/?p=1379">Backup Journey to rsnapshot</a></p>
<h2>Install Rsnapshot</h2>
<p>The easiest way to install unix programs in OSX is to use <a href="http://brew.sh/">Homebrew</a>, after installing Homebrew install rsnapshot and needed programs:</p>
<p><code></p>
<pre>
$ brew update
$ brew install rsnapshot
$ brew install coreutils
</pre>
<p></code></p>
<p>&#8220;coreutils&#8221; is needed because &#8220;cp&#8221; command installed with OSX doesn&#8217;t support GNU &#8220;cp&#8221; options needed for rsnapshot.</p>
<h2>Configuration</h2>
<p>I will be running rsnapshot from user account and not root user, I will be using my user &#8220;rayed&#8221;:</p>
<p><code></p>
<pre>
$ mkdir /Users/rayed/rsnapshot
$ cat &gt; /Users/rayed/rsnapshot/rsnapshot.conf &lt;&lt; EOF
#################################################
# rsnapshot.conf - rsnapshot configuration file #
#################################################
#                                               #
# PLEASE BE AWARE OF THE FOLLOWING RULES:       #
#                                               #
# This file requires tabs between elements      #
#                                               #
# Directories require a trailing slash:         #
#   right: /home/                               #
#   wrong: /home                                #
#                                               #
#################################################
config_version	1.2

snapshot_root	/Users/rayed/rsnapshot/

cmd_cp		/usr/local/bin/gcp
cmd_rm		/bin/rm
cmd_rsync	/usr/bin/rsync
cmd_ssh		/usr/bin/ssh
cmd_logger	/usr/bin/logger

retain		hourly	4
retain		daily	7
retain		weekly	4
retain		monthly	3

verbose		2
loglevel	3
logfile		/Users/rayed/rsnapshot/rsnapshot.log
lockfile	/Users/rayed/rsnapshot.pid

# Backup local machine
backup		/Users/rayed/	localhost/
# Backup remote machine
backup		rayed@example.com:/home/rayed/	example.com/
EOF
</pre>
<p></code></p>
<p>Important notes about the configuration files:</p>
<ul>
<li>Use <strong>TABs</strong> not spaces between elements.</li>
<li>Directories require a trailing slash, i.e. /home/ not /home</li>
<li>On OSX we replaced &#8220;cmd_cp&#8221; from &#8220;/bin/cp&#8221; to &#8220;/usr/local/bin/gcp&#8221; to support rsnapshot options.</li>
<li>For remote machine backup, make sure you use ssh keys, Rsnapshot can&#8217;t use passwords.</li>
</ul>
<h2>Running rsnapshot</h2>
<p>To test your setup try the following command:<br />
<code></p>
<pre>rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf hourly</pre>
<p></code></p>
<p>When everything works fine, you need to configure &#8220;rsnapshot&#8221; to run periodically from cron, install the following line:<br />
<code></p>
<pre>
$ crontab -e
:
# RSnapshot
0 */6 * * *	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf hourly
30 3 * * *	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf daily
0  3 * * 1	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf weekly
30 2 1 * *	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf monthly
</pre>
<p></code></p>
<p>After few hours double check your setup by making reviewing the log file &#8220;/Users/rayed/rsnapshot/rsnapshot.log&#8221;, and check the rsnapshot root directory for your backups, you should have something like:<br />
<code></p>
<pre>
$ ls -l /Users/rayed/rsnapshot/
hourly.0
hourly.1
hourly.2
hourly.3
daily.0
daily.1
:
</pre>
<p></code></p>
