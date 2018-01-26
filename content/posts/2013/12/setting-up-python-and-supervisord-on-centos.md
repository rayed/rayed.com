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

CentOS default repository is very limited, and even if you install <a href="https://fedoraproject.org/wiki/EPEL">EPEL</a> you will get old packages, in my case I needed to install <a href="http://supervisord.org/">Supervisor</a> to manage my Django application, after trying to do it manually and through EPEL I ended up with the following setup.<!--more-->


### Install Needed Package

    sudo yum install python-setuptools
    sudo easy_install pip
    sudo pip install supervisor


### Setup Supervisor


We've already installed "Supervisor" globally, but we need to create its configuration, luckily it comes with default config:

    echo_supervisord_conf > supervisord.conf
    sudo cp supervisord.conf /etc/supervisord.conf
    sudo mkdir /etc/supervisord.d/
    sudo vi /etc/supervisord.conf
    :
    [include]
    files = /etc/supervisord.d/*.conf
    :

Next we need to set "Supervisor" to run automatically every time you restart your machine, we need to create <strong>/etc/rc.d/init.d/supervisord</strong> with the following content:

    sudo vi /etc/rc.d/init.d/supervisord
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

Then make sure CentOS knows about it:

    sudo chmod +x /etc/rc.d/init.d/supervisord
    sudo chkconfig --add supervisord
    sudo chkconfig supervisord on
    sudo service supervisord start


### Sample Supervisor App


Here is a sample of Django App to be controlled and monitored by Supervisor, just put it:

    sudo vi /etc/supervisord.d/my_django_cms.conf
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

After that:

    sudo supervisorctl add my_django_cms
    sudo supervisorctl start my_django_cms


### Setting Apache to Proxy to Gunicorn


To add virtual host to Apache that forward dynamic content to Gunicorn:

    sudo vi /etc/httpd/conf.d/my_django_cms.conf
    NameVirtualHost *:80
    <VirtualHost *:80>
        ServerName dj.example.com
        ServerAdmin webmaster@example.com
        DocumentRoot /var/www/my_django_cms/www
        RewriteEngine on
        ProxyPreserveHost On
        RewriteCond $1 !^/(favicon\.ico|robots\.txt|media|static)/
        RewriteRule ^(.*) http://localhost:8000$1 [P]
        <Proxy *>
                Order deny,allow
                Allow from all
                Allow from localhost
        </Proxy>
    </VirtualHost>

If you have SELinux enabled you might need to apply the following command:

    setsebool -P httpd_can_network_connect 1

If you have issues accessing your statics files from Apache it might be SELinux also:

    restorecon -Rv /var/www/my_django_cms/
