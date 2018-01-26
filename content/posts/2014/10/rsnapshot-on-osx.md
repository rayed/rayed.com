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

Rsnapshot is a backup solution for Unix machines including Linux and OSX, it supports many great features including full backups with the size of only incremental backup, it also support backing up local and remote machines.

<!--more-->

Check my previous post for more details about it, [Backup Journey to rsnapshot](/blog/posts/2013/09/rsnapshot-protect-your-self-from-delete-mistakes/)

### Install Rsnapshot

The easiest way to install unix programs in OSX is to use <a href="http://brew.sh/">Homebrew</a>, after installing Homebrew install rsnapshot and needed programs:

    $ brew update
    $ brew install rsnapshot
    $ brew install coreutils

"coreutils" is needed because "cp" command installed with OSX doesn't support GNU "cp" options needed for rsnapshot.

### Configuration

I will be running rsnapshot from user account and not root user, I will be using my user "rayed":

    $ mkdir /Users/rayed/rsnapshot
    $ cat > /Users/rayed/rsnapshot/rsnapshot.conf << EOF
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

Important notes about the configuration files:

- Use <strong>TABs</strong> not spaces between elements.
- Directories require a trailing slash, i.e. /home/ not /home
- On OSX we replaced "cmd_cp" from "/bin/cp" to "/usr/local/bin/gcp" to support rsnapshot options.
- For remote machine backup, make sure you use ssh keys, Rsnapshot can't use passwords.


### Running rsnapshot

To test your setup try the following command:

    rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf hourly

When everything works fine, you need to configure "rsnapshot" to run periodically from cron, install the following line:

    $ crontab -e
    :
    # RSnapshot
    0 */6 * * *	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf hourly
    30 3 * * *	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf daily
    0  3 * * 1	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf weekly
    30 2 1 * *	/usr/local/bin/rsnapshot -c /Users/rayed/rsnapshot/rsnapshot.conf monthly

After few hours double check your setup by making reviewing the log file "/Users/rayed/rsnapshot/rsnapshot.log", and check the rsnapshot root directory for your backups, you should have something like:

    $ ls -l /Users/rayed/rsnapshot/
    hourly.0
    hourly.1
    hourly.2
    hourly.3
    daily.0
    daily.1
    :
