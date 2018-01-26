---
title: Setting Up Python and Supervisor on CentOS
author: Rayed
type: post
date: 2013-12-12T14:55:33+03:00
categories:
  - Uncategorized
tags:
  - centos
  - django
  - python
wordpress_id: 1496

---
<p>CentOS default repository is very limited, and even if you install <a href="https://fedoraproject.org/wiki/EPEL">EPEL</a> you will get old packages, in my case I needed to install <a href="http://supervisord.org/">Supervisor</a> to manage my Django application, after trying to do it manually and through EPEL I ended up with the following setup.</p>
<h2>Install Needed Package</h2>
<pre><code>sudo yum install python-setuptools
sudo easy_install pip
sudo pip install supervisor
</code></pre>
<p><!--


<h2>Install Virtualenv Wrapper
We don't need virtualenvwrapper to setup Supervisord, but it is convenient to use for Python project, for more info check an older post <a href="http://rayed.com/wordpress/?p=1142">Managing Python Environments with “virtualenvwrapper”</a>.

To install it we need the following steps:



<pre><code>sudo pip install virtualenvwrapper
vi ~/.bashrc
:
# Add the following 2 lines at the end to .bashrc
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
# end .bashrc change
</code></pre>



To activate it logout and login again.
--></p>
<h2>Setup Supervisor</h2>
<p>We&#8217;ve already installed &#8220;Supervisor&#8221; globally, but we need to create its configuration, luckily it comes with default config:</p>
<pre><code>echo_supervisord_conf &gt; supervisord.conf
sudo cp supervisord.conf /etc/supervisord.conf
sudo mkdir /etc/supervisord.d/
sudo vi /etc/supervisord.conf
:
[include]
files = /etc/supervisord.d/*.conf
:
</code></pre>
<p>Next we need to set &#8220;Supervisor&#8221; to run automatically every time you restart your machine, we need to create <strong>/etc/rc.d/init.d/supervisord</strong> with the following content:</p>
<pre><code>sudo vi /etc/rc.d/init.d/supervisord
#!/bin/sh
#
# /etc/rc.d/init.d/supervisord
#
# Supervisor is a client/server system that
# allows its users to monitor and control a
# number of processes on UNIX-like operating
# systems.
#
# chkconfig: - 64 36
# description: Supervisor Server
# processname: supervisord

# Source init functions
. /etc/rc.d/init.d/functions

prog="supervisord"

prefix="/usr/"
exec_prefix="${prefix}"
prog_bin="${exec_prefix}/bin/supervisord"
PIDFILE="/var/run/$prog.pid"

start()
{
       echo -n $"Starting $prog: "
       daemon $prog_bin --pidfile $PIDFILE
       [ -f $PIDFILE ] &amp;&amp; success $"$prog startup" || failure $"$prog startup"
       echo
}

stop()
{
       echo -n $"Shutting down $prog: "
       [ -f $PIDFILE ] &amp;&amp; killproc $prog || success $"$prog shutdown"
       echo
}

case "$1" in

 start)
   start
 ;;

 stop)
   stop
 ;;

 status)
       status $prog
 ;;

 restart)
   stop
   start
 ;;

 *)
   echo "Usage: $0 {start|stop|restart|status}"
 ;;

esac
</code></pre>
<p>Then make sure CentOS knows about it:</p>
<pre><code>sudo chmod +x /etc/rc.d/init.d/supervisord
sudo chkconfig --add supervisord
sudo chkconfig supervisord on
sudo service supervisord start
</code></pre>
<h2>Sample Supervisor App</h2>
<p>Here is a sample of Django App to be controlled and monitored by Supervisor, just put it:</p>
<pre><code>sudo vi /etc/supervisord.d/my_django_cms.conf
[program:my_django_cms]
directory=/var/www/dashboard/www
command=/home/rayed/.virtualenvs/dev/bin/gunicorn apps.wsgi:application -b 127.0.0.1:8080 --workers 8 --max-requests 1000
# UNIX Socket version (better with Nginx)
#command=/home/rayed/.virtualenvs/dev/bin/gunicorn apps.wsgi:application -b unix:/tmp/my_django_cms.sock --workers 8  --max-requests 1000
environment=DJANGO_ENV="prod"
user=rayed
autostart=true
autorestart=true
redirect_stderr=True
</code></pre>
<p>After that:</p>
<pre><code> sudo supervisorctl add my_django_cms
 sudo supervisorctl start my_django_cms
</code></pre>
<h2>Setting Apache to Proxy to Gunicorn</h2>
<p>To add virtual host to Apache that forward dynamic content to Gunicorn:</p>
<pre><code>sudo vi /etc/httpd/conf.d/my_django_cms.conf
NameVirtualHost *:80
&lt;VirtualHost *:80&gt;
    ServerName dj.example.com
    ServerAdmin webmaster@example.com
    DocumentRoot /var/www/my_django_cms/www
    RewriteEngine on
    ProxyPreserveHost On
    RewriteCond $1 !^/(favicon\.ico|robots\.txt|media|static)/
    RewriteRule ^(.*) http://localhost:8000$1 [P]
    &lt;Proxy *&gt;
            Order deny,allow
            Allow from all
            Allow from localhost
    &lt;/Proxy&gt;
&lt;/VirtualHost&gt;
</code></pre>
<p>If you have SELinux enabled you might need to apply the following command:</p>
<pre><code>setsebool -P httpd_can_network_connect 1
</code></pre>
<p>If you have issues accessing your statics files from Apache it might be SELinux also:</p>
<pre><code>restorecon -Rv /var/www/my_django_cms/
</code></pre>
