---
title: Backup Journey to rsnapshot
author: Rayed
type: post
date: 2013-09-18T14:09:03+03:00
categories:
  - Uncategorized
tags:
  - backup
  - debian
  - linux
  - rsnapshot
  - rsync
  - sysamdin
  - ubuntu
wordpress_id: 1379

---
When I started producing backup worthy files (code, documents, projects, etc ...), I realised the importance of backups after losing important files which happens to everybody. So I started my journey with backup solutions.

**Backup generation 1:** My first backup was simple directory copy operation, I copied my important directories to external floppy (then CD), and since it is manual operation I always forget about it and my backups was always old.

**Backup Generation 2:** Later when I moved to Linux I automated the backup process using a "cron" job, I backed up everything daily to a single file 'backup.tar.gz'

**Backup Generation 3:** One day I noticed that I deleted a file by mistake ... no problem I'll restore it from backup ... but it wasn't there! I realised that I deleted the folder 2 days ago and the backup is overwritten daily! The solution is to backup daily to a different file name e.g. 'backup-monday.tar.gz' to have one week worth of backups.

**Backup Generation 4:** It happened again I deleted a file and had to restore from backup, this time I am prepared, Unarchive 'backup-moday.tar.gz' and couldn't find the file, try 'backup-sunday.tar.gz' not found either, finally I found it on 'backup-saturday.tar.gz', it took me a while but at least I found the file. But now I have another problem, all these backups are taking large amount of my disk space.

So far the problems I have are:

- Backups takes long time to complete: I have to copy all files and directories and compress them!
- Backups eat my disk space: complete backup for 7 days is too much to handle, I also want weekly and monthly backups but can't afford to lose more disk space!
- Searching and restoring the backup is very slow process.

Then I found **rsnapshot**!


### rsnapshot

rsnapshot is backup tool that solve all my previous problems and more, this how it works:

> Using rsync and hard links, it is possible to keep multiple, full backups instantly available. The disk > space required is just a little more than the space of one full backup, plus incrementals.


#### Installation

To install **rsnapshot** from Ubuntu or Debian systems:

    $ sudo aptitude install rsnapshot


#### Activation

**rsnapshot** isn't a deamon (server or a service), it works periodically as a cron job, and by default it is disabled, to activate open the file `/etc/cron.d/rsnapshot` and uncomment all jobs:

    $ sudo vi /etc/cron.d/rsnapshot
    # Uncomment all lines to activate rsnapshot 
    0 */4 * * * root /usr/bin/rsnapshot hourly 
    30 3 * * * root /usr/bin/rsnapshot daily 
    0 3 * * 1 root /usr/bin/rsnapshot weekly 
    30 2 1 * * root /usr/bin/rsnapshot monthly 


#### Configuration

The default configuration for **rsnapshot** is to backup the following local directories, `/home`, `/etc`, and `/usr/local`. If you want to change it edit the file `/etc/rsnapshot.conf`.

    $ sudo vi /etc/rsnapshot.conf 
    :
    snapshot_root /var/cache/rsnapshot/
    :
    retain          hourly  6
    retain          daily   7
    retain          weekly  4
    retain          monthly  3
    :
    # LOCALHOST
    backup  /home/          localhost/
    backup  /etc/           localhost/
    backup  /usr/local/     localhost/


#### Where is My Data?

**rsnapshot** backup everything in the directory defined in `snapshot_root` in the config file, by default it is `/var/cache/rsnapshot/`, after running for few days you would have the following directory structure:

    /var/cache/rsnapshot
                      hourly.0
                              localhost
                                        etc
                                        home
                                        usr
                      hourly.1
                      :
                      daily.0
                      daily.1
                      :
                      weekly.0
                      weekly.1
                      :
                      monthly.0
                      monthly.1
                      :

Of course the number of directories reflect the retain value in the configuration.

What I have now is a the following backups:

- Hourly backup: performed every 4 hours, and I keep the last 6 versions, i.e. 24 hours worth of backups. 
- Daily backup: I keep the last 7 version to cover the whole week.
- Weekly backup: I keep the last 4 weeks to cover a whole month. 
- Monthly backup: I keep the last 4 monthly backups.

To give you a perspective on how much **rsnapshot** disk space the `hourly.0` size is 7 GB, `hourly.1` size is only 120 MB

**NOTE:** You would need root permission to access the directory `/var/cache/rsnapshot`

