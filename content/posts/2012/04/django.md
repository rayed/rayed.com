---
title: Deploying Django
author: Rayed
type: post
date: 2012-04-28T03:07:30+03:00
categories:
  - Uncategorized
tags:
  - django
  - gunicorn
  - python
wordpress_id: 920

---
<p><a href="https://www.djangoproject.com/">Django</a> is a web framework written in <a href="http://www.python.org/">Python</a> language, my favourite computer programming language.</p>
<p>Python a language is really great language, easy to read and understand, and very easy to learn, but for me I always found setting up Python for web development as a challenge, socially if compare it to PHP, which almost works out of the box, actually most people think PHP works only in the web server and can&#8217;t work as stand alone application, search for PHP CLI if you are interested.</p>
<p>I will try here to document an easy Django deployment for my future reference and hopefully it will help others: <!--more--></p>
<h2>Step 1: Install virtualenv</h2>
<p><strong>virtualenv</strong> is a tool to create isolated Python environments, by default if you install a new Python package it will be install under <code>/usr/lib/python2.6/site-packages</code>, but what happen if you don&#8217;t have root access in a shared environment for example, or what if you want to install 2 versions of the same package, may be try a newer version. For these cases you need <strong>virtualenv</strong>, it will allow you to create your own unique Python environment (or many if you want) where you have your own packages, binaries, and scripts. You can even have multiple environments, wach one with its own packages and versions. So let&#8217;s install it (this step need root access, ask your admin to install it for you if you don&#8217;t have root):</p>
<pre><code>$ sudo pip install virtualenv
# or ...
$ sudo aptitude install python-virtualenv
</code></pre>
<p>Next we will create a new virtual environment &#8220;myenv&#8221;:</p>
<pre><code>$ virtualenv myenv
</code></pre>
<p>To activate it type:</p>
<pre><code>$ source myenv/bin/activate
(myenv)$ 
</code></pre>
<p>You will notice that the prompt changed now to include &#8220;(myenv)&#8221;, this mean you are now inside the virtual enviroument, any thing you install from now on will be install inside it (it is just a directory called &#8220;myenv&#8221; feel free to explore it), to leave the environment use the command &#8220;deactivate&#8221;.</p>
<h2>Step 2: Installing Django</h2>
<p>Make sure you the &#8220;myvirt&#8221; is active (from the prompt) and install Django using the following command:</p>
<pre><code>(myenv)$ pip install Django
</code></pre>
<p>That is it, we&#8217;ve installed Django &#8230; Thank you for your attention 🙂 Next we will setup a new Django website, I will use the following directory structure:</p>
<pre><code>$ /home/rayed                # my home directory
$ /home/rayed/site1          # my website files and directories 
$ /home/rayed/site1/myenv    # virtual environment created from previous step
$ /home/rayed/site1/mysite   # Django created project
$ /home/rayed/site1/www      # Static files, images, css, js, etc ... 
</code></pre>
<p>So here are the commands for easy reference:</p>
<pre><code>$ cd ~
$ mkdir -p site1/www
$ cd site1
site1$ virtualenv myenv
site1$ source myenv/bin/activate
(myenv)site1$ pip install Django
(myenv)site1$ django-admin.py startproject mysite
(myenv)site1$ cd mysite
(myenv)site1/mysite$ python manage.py runserver 0.0.0.0:8000
:
this will start dev server CTRL+C to stop
you can access it http://localhost:8000/
:
(myenv)site1/mysite$ vi mysite/settings.py     # this will setup the database
(myenv)site1/mysite$ python manage.py syncdb   # this will install basic DB tables
</code></pre>
<h2>Step 3: GUnicorn</h2>
<p>For production website you will not use Django development web server, we will use <a href="http://gunicorn.org/">gunicorn</a>, a Python WSGI HTTP Server, it will responsible for running all Django code.</p>
<pre><code># while inside "myenv" install guincorn
(myenv)$ pip install gunicorn
# and run Django
(myenv)$ cd ~/site1/mysite
(myenv) site1/mysite$ gunicorn apps.wsgi:application -b 0.0.0.0:8000
</code></pre>
<p>Try it out <a href="http://localhost:8000/">http://localhost:8000/</a></p>
<pre><code># NOTE: to run gunicorn on UNIX socket use:
gunicorn apps.wsgi:application -b unix:/tmp/gunicorn.sock
</code></pre>
<h2>Step 4: Install supervisor (optional)</h2>
<p>We will use <a href="http://supervisord.org/">supervisor </a> to keep an eye on &#8220;gunicorn&#8221;, and restart it automatically if it fails, it will also start it automatically when you restart the machine.</p>
<pre><code>$ sudo aptitude install supervisor
$ cat &gt; /etc/supervisor/conf.d/gunicorn.conf 
[program:gunicorn]
directory=/home/rayed/site1/mysite/
command=/home/rayed/site1/myenv/bin/gunicorn apps.wsgi:application -b 127.0.0.1:8000
user=nobody
autostart=true
autorestart=true
redirect_stderr=True
[EOF]
$ sudo supervisorctl update
$ sudo supervisorctl restart gunicorn
</code></pre>
<h2>Step 5: Integrating gunicorn with Apache</h2>
<p>gunicorn is a web server, so why do we need Apache? you ask, two reasons:</p>
<p>1- It can&#8217;t handle slow clients (browsers). 2- It can&#8217;t handle static files (images, css, js).</p>
<p>The basic idea is to serve static files directly from (img|css|js|media) and proxy everything else to &#8220;gunicorn&#8221;, here is how:</p>
<pre><code>$ sudo a2enmod proxy_http   # enable Apache HTTP proxy module (Ubuntu &amp; Debian)
$ sudo apache2ctl restart
$ cd ~site1/www
$ site1/www$ cat &gt; .htaccess
RewriteEngine on
RewriteCond $1 !^(img|css|js|robots\.txt|media)
RewriteRule ^(.*) http://localhost:8000/$1 [P]
[EOF]
</code></pre>
<p><strong>Make sure only &#8220;www&#8221; directory is accessible from the web, and not &#8220;mysite&#8221;! your Django code and settings, including the DB username and password will be exposed.</strong></p>
<p>A sample Apache virtual host configuration: `</p>
<pre><code>&lt;virtualhost *:80&gt;
    ServerName site1.rayed.com
    DocumentRoot /home/rayed/site1/www
&lt;/virtualhost&gt;
</code></pre>
<p>You can also replace Apache with <a href="http://wiki.nginx.org/Main">Nginx</a> which is usually faster with static files, here is a sample file:</p>
<pre><code>upstream app_server {
    server unix:/tmp/gunicorn.sock fail_timeout=0;
    # For a TCP configuration:
    # server 127.0.0.1:8000 fail_timeout=0;
}
server {
    listen       80 ;
    server_name  site1.rayed.com;

    location ~ /(css|js|media|static)/ { # Static content
        root /home/rayed/site1/www/;
        expires 30d;
    }

    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass   http://app_server;
    }
}
</code></pre>
