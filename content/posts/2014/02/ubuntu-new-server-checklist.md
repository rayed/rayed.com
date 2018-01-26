---
title: Ubuntu new server checklist
author: Rayed
type: post
date: 2014-02-05T12:31:15+03:00
categories:
  - Uncategorized
tags:
  - linux
  - ubuntu
wordpress_id: 1525

---

These are the step I perform after installing new Ubuntu machine.<!--more-->


### Create Admin User

As root create new user for management, after that you should never use root:

    root# adduser myuser
    root# passwd myuser
    # Add user to sudo group
    root# usermod -a -G sudo myuser

You should logout from "root" and login again using your new "user"


### Setting Up Admin User

Add your public key to the admin user for password less access

    $ mkdir ~/.ssh
    $ vi ~/.ssh/authorized_keys
    :
    paste your public key e.g. id_rsa.pub
    :


### Setup

Change the default editor from nano to vi (if you want):

    $ sudo update-alternatives --config editor

Setup system update without a password:

    $ sudo visudo 
    :
    Cmnd_Alias APTITUDE = /usr/bin/aptitude update, /usr/bin/aptitude upgrade
    %sudo ALL=(ALL) NOPASSWD: APTITUDE

Fix the timezone:

    $ sudo dpkg-reconfigure tzdata

Install "ntp" if not already installed:

    $ sudo aptitude install ntp


### Change hostname

    $ sudo hostname s5.rayed.com
    $ sudo sh -c "echo 's5.rayed.com' &gt; /etc/hostname "
    $ sudo vi /etc/resolv.conf
    :
    domain rayed.com
    search rayed.com
    :
    $ sudo vi /etc/hosts 
    :
    178.79.x.x  s5     s5.rayed.com
    :


### Update the machine

    $ sudo aptitude update
    $ sudo aptitude upgrade
    $ sudo reboot


### Configure Mail Server

I usually install Exim mail server as "internet site" but listening to localhost only, this the needed commands: 

    sudo aptitude install exim4-daemon-light
    sudo dpkg-reconfigure exim4-config

Try sending an email to your self, and check the log:

    date | sendmail rayed@example.com
    sudo tail -f /var/log/exim4/mainlog


