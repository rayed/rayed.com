---
title: Protect your Server with Fail2Ban
author: Rayed
type: post
date: 2014-07-14T17:07:06+03:00
categories:
  - Uncategorized
tags:
  - linux
  - security
  - spam
  - ssh
  - ubuntu
  - wordpress
wordpress_id: 1633

---
<p>Fail2ban is a program that scan your log files for any malicious behavior, and automatically block the offending IP.</p>
<p>The default Fail2ban installation on Ubuntu will protect ssh, but in this article I will show how to protect against WordPress comment spammers too, to slow them down.</p>
<h2>Installation &#038; Configuration</h2>
<p><code></p>
<pre>
# Install fail2ban
$ sudo apt-get install fail2ban

# Copy default config to custom config
$ sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Add your own IPs so they never get blocked
$ sudo vi /etc/fail2ban/jail.local
:
ignoreip = 127.0.0.1/8 10.0.0.0/8 192.168.1.5
:

# restart it
$ sudo service fail2ban restart
</pre>
<p></code></p>
<p>Fail2ban is now configured and running.</p>
<p>You can use the following commands to inspect and trouble shoot its operation:</p>
<p><code></p>
<pre>
# fail2ban usually add new rules to your IPTables
$ sudo iptables -L

# You can check the status of specific rules using the command:
$ sudo fail2ban-client status ssh

# and of course check log to see if it is working:
$ sudo tail -f /var/log/fail2ban.log 
</pre>
<p></code></p>
<h2>Protecting WordPress Comments</h2>
<p>By default fail2ban protect many services including ssh but let&#8217;s assume you want to protect WordPress from spam bots trying to post comments on your blog.</p>
<p>First we add a filter to catch the attempts by creating new filter file named &#8220;/etc/fail2ban/filter.d/wordpress-comment.conf&#8221;:</p>
<p><code></p>
<pre>
$ sudo vi /etc/fail2ban/filter.d/wordpress-comment.conf 
#
# Block IPs trying to post many comments
#
[Definition]
failregex = ^&lt;HOST> -.*POST /wordpress/wp-comments-post.php
</pre>
<p></code></p>
<p>Then we create a new JAIL by adding the following to &#8220;jail.local&#8221; file:</p>
<p><code></p>
<pre>
$ sudo vi /etc/fail2ban/jail.local
:
:
[wordpress-comment]
enabled = true
port = http,https
filter = wordpress-comment
logpath = /var/log/apache2/*access*.log
bantime = 3600
maxretry = 5
</pre>
<p></code></p>
<p>Then restart fail2ban using:</p>
<p><code></p>
<pre>sudo service fail2ban restart</pre>
<p></code></p>
<p><strong>Note:</strong> To test if your filter work you can use the command &#8220;fail2ban-regex&#8221;:<br />
<code></p>
<pre>fail2ban-regex /var/log/apache2/other_vhosts_access.log filter.d/wordpress-comment.conf </pre>
<p></code></p>
