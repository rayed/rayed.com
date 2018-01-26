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
<h2>Create Admin User</h2>
<p>As root create new user for management, after that you should never use root:</p>
<pre><code>root# adduser myuser
root# passwd myuser
# Add user to sudo group
root# usermod -a -G sudo myuser
</code></pre>
<p>You should logout from &#8220;root&#8221; and login again using your new &#8220;user&#8221;</p>
<h2>Setting Up Admin User</h2>
<p>Add your public key to the admin user for password less access</p>
<pre><code>$ mkdir ~/.ssh
$ vi ~/.ssh/authorized_keys
:
paste your public key e.g. id_rsa.pub
:
</code></pre>
<h2>Setup</h2>
<p>Change the default editor from nano to vi (if you want):</p>
<pre><code>$ sudo update-alternatives --config editor
</code></pre>
<p>Setup system update without a password:</p>
<pre><code>$ sudo visudo 
:
Cmnd_Alias APTITUDE = /usr/bin/aptitude update, /usr/bin/aptitude upgrade
%sudo ALL=(ALL) NOPASSWD: APTITUDE
</code></pre>
<p>Fix the timezone:</p>
<pre><code>$ sudo dpkg-reconfigure tzdata
</code></pre>
<p>Install &#8220;ntp&#8221; if not already installed:</p>
<pre><code>$ sudo aptitude install ntp
</code></pre>
<h2>Change hostname</h2>
<pre><code>$ sudo hostname s5.rayed.com
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
</code></pre>
<h2>Update the machine</h2>
<pre><code>$ sudo aptitude update
$ sudo aptitude upgrade
$ sudo reboot
</code></pre>
<h2>Configure Mail Server</h2>
<p>I usually install Exim mail server as &#8220;internet site&#8221; but listening to localhost only, this the needed commands: </p>
<pre><code>
sudo aptitude install exim4-daemon-light
sudo dpkg-reconfigure exim4-config
</code></pre>
<p>Try sending an email to your self, and check the log:</p>
<pre><code>
date | sendmail rayed@example.com
sudo tail -f /var/log/exim4/mainlog
</code></pre>
