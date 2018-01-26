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
So you managed to login to your Ubuntu Linux machine with a password by using the magic of ssh keys, and you installed "apticron" to email you whenever their is a system update, you login to the system and issue the update command "sudo aptitude update" and "sudo" asks you about your password! not only it is annoying, it also can't be automated, imaging you manage 10 servers and you have to type the password to update each machine! or you want to automate using some remote execution application like <a href="http://docs.fabfile.org/">Fabric</a> or <a href="http://www.saltstack.com/">Salt</a> <small>(I am Python fan, so I won't mention Chef or Puppet here)</small>.

The solution is very simple and most likely you already know it "sudo", "sudo" can be configured not to ask for password for given command very easily:


    $ sudo visudo
    :
    # Add the following lines
    Cmnd_Alias APTITUDE = /usr/bin/aptitude update, /usr/bin/aptitude upgrade
    rayed ALL=(ALL) NOPASSWD: APTITUDE
    :

Now you can issue update commands with the need for password:

    $ sudo aptitude update
    $ sudo aptitude upgrade -y

The previous snippet are for "Ubuntu" systems, for "Red Hat" and "CentOS" you have to change the commands "aptitude update/upgrade" with "yum update". 

