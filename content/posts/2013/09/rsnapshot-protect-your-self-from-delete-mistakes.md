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
<p>When I started producing backup worthy files (code, documents, projects, etc &#8230;), I realised the importance of backups after losing important files which happens to everybody. So I started my journey with backup solutions.</p>
<p><strong>Backup generation 1:</strong> My first backup was simple directory copy operation, I copied my important directories to external floppy (then CD), and since it is manual operation I always forget about it and my backups was always old.</p>
<p><strong>Backup Generation 2:</strong> Later when I moved to Linux I automated the backup process using a &#8220;cron&#8221; job, I backed up everything daily to a single file &#8216;backup.tar.gz&#8217;</p>
<p><strong>Backup Generation 3:</strong> One day I noticed that I deleted a file by mistake &#8230; no problem I&#8217;ll restore it from backup &#8230; but it wasn&#8217;t there! I realised that I deleted the folder 2 days ago and the backup is overwritten daily! The solution is to backup daily to a different file name e.g. &#8216;backup-monday.tar.gz&#8217; to have one week worth of backups.</p>
<p><strong>Backup Generation 4:</strong> It happened again I deleted a file and had to restore from backup, this time I am prepared 🙂 Unarchive &#8216;backup-moday.tar.gz&#8217; and couldn&#8217;t find the file, try &#8216;backup-sunday.tar.gz&#8217; not found either, finally I found it on &#8216;backup-saturday.tar.gz&#8217;, it took me a while but at least I found the file. But now I have another problem, all these backups are taking large amount of my disk space.</p>
<p>So far the problems I have are:</p>
<ul>
<li>Backups takes long time to complete: I have to copy all files and directories and compress them!</li>
<li>Backups eat my disk space: complete backup for 7 days is too much to handle, I also want weekly and monthly backups but can&#8217;t afford to lose more disk space!</li>
<li>Searching and restoring the backup is very slow process.</li>
</ul>
<p>Then I found <strong>rsnapshot</strong>!</p>
<h2>rsnapshot</h2>
<p>rsnapshot is backup tool that solve all my previous problems and more, this how it works:</p>
<blockquote>
<p>Using rsync and hard links, it is possible to keep multiple, full backups instantly available. The disk space required is just a little more than the space of one full backup, plus incrementals.</p>
</blockquote>
<h3>Installation</h3>
<p>To install <strong>rsnapshot</strong> from Ubuntu or Debian systems:</p>
<pre><code>$ sudo aptitude install rsnapshot
</code></pre>
<h3>Activation</h3>
<p><strong>rsnapshot</strong> isn&#8217;t a deamon (server or a service), it works periodically as a cron job, and by default it is disabled, to activate open the file <code>/etc/cron.d/rsnapshot</code> and uncomment all jobs:</p>
<pre><code>$ sudo vi /etc/cron.d/rsnapshot
# Uncomment all lines to activate rsnapshot 
0 */4 * * * root /usr/bin/rsnapshot hourly 
30 3 * * * root /usr/bin/rsnapshot daily 
0 3 * * 1 root /usr/bin/rsnapshot weekly 
30 2 1 * * root /usr/bin/rsnapshot monthly 
</code></pre>
<h3>Configuration</h3>
<p>The default configuration for <strong>rsnapshot</strong> is to backup the following local directories, <code>/home</code>, <code>/etc</code>, and <code>/usr/local</code>. If you want to change it edit the file <code>/etc/rsnapshot.conf</code>.</p>
<pre><code>$ sudo vi /etc/rsnapshot.conf 
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
</code></pre>
<h3>Where is My Data?</h3>
<p><strong>rsnapshot</strong> backup everything in the directory defined in <code>snapshot_root</code> in the config file, by default it is <code>/var/cache/rsnapshot/</code>, after running for few days you would have the following directory structure:</p>
<pre><code>/var/cache/rsnapshot
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
</code></pre>
<p>Of course the number of directories reflect the retain value in the configuration.</p>
<p>What I have now is a the following backups:</p>
<ul>
<li>Hourly backup: performed every 4 hours, and I keep the last 6 versions, i.e. 24 hours worth of backups. </li>
<li>Daily backup: I keep the last 7 version to cover the whole week.</li>
<li>Weekly backup: I keep the last 4 weeks to cover a whole month. </li>
<li>Monthly backup: I keep the last 4 monthly backups.</li>
</ul>
<p>To give you a perspective on how much <strong>rsnapshot</strong> disk space the <code>hourly.0</code> size is 7 GB, <code>hourly.1</code> size is only 120 MB</p>
<p><strong>NOTE:</strong> You would need root permission to access the directory <code>/var/cache/rsnapshot</code></p>
