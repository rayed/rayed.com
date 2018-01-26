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

Fail2ban is a program that scan your log files for any malicious behavior, and automatically block the offending IP.<!--more-->

The default Fail2ban installation on Ubuntu will protect ssh, but in this article I will show how to protect against WordPress comment spammers too, to slow them down.


### Installation & Configuration

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


Fail2ban is now configured and running.

You can use the following commands to inspect and trouble shoot its operation:

    # fail2ban usually add new rules to your IPTables
    $ sudo iptables -L

    # You can check the status of specific rules using the command:
    $ sudo fail2ban-client status ssh

    # and of course check log to see if it is working:
    $ sudo tail -f /var/log/fail2ban.log 



### Protecting WordPress Comments

By default fail2ban protect many services including ssh but let's assume you want to protect WordPress from spam bots trying to post comments on your blog.


First we add a filter to catch the attempts by creating new filter file named "/etc/fail2ban/filter.d/wordpress-comment.conf":

    $ sudo vi /etc/fail2ban/filter.d/wordpress-comment.conf 
    #
    # Block IPs trying to post many comments
    #
    [Definition]
    failregex = <HOST> -.*POST /wordpress/wp-comments-post.php

Then we create a new JAIL by adding the following to "jail.local" file:

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

Then restart fail2ban using:

    sudo service fail2ban restart  

**Note:** To test if your filter work you can use the command "fail2ban-regex":

    fail2ban-regex /var/log/apache2/other_vhosts_access.log filter.d/wordpress-comment.conf