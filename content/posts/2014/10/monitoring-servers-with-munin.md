---
title: Monitoring Servers with Munin
author: Rayed
type: post
date: 2014-10-23T14:26:51+03:00
categories:
  - Uncategorized
tags:
  - admin
  - linux
  - memcache
  - monitoring
  - munin
  - MySQL
  - nginx
  - ubuntu
wordpress_id: 1681

---
<p>This is a draft on configuring Munin to monitor services on a Linux machine, still dirty but published for my reference, if you have question let me know.</p>
<h2>Monitoring Servers</h2>
<pre>
sudo apt-get install munin

sudo htpasswd -c /etc/munin/htpasswd rayed

vi vi /etc/munin/munin-conf.d/example_com_site
:
[munin-node.example.com]
    address munin-node.example.com
    use_node_name yes
:


sudo vi vi /etc/nginx/sites-enabled/default
server {
:
location /munin/static/ {
        alias /etc/munin/static/;
        expires modified +1w;
}

location /munin/ {
        auth_basic            "Restricted";
        auth_basic_user_file  /etc/munin/htpasswd;

        alias /var/cache/munin/www/;
        expires modified +310s;
}
:
}
</pre>
<h2>Monitored Servers</h2>
<pre>
sudo apt-get install munin-node
sudo apt-get install munin-plugins-extra

sudo vi /etc/munin/munin-node.conf
:
allow ^172\.18\.100\.100$   # monitoring server address
:
</pre>
<h3>Muni-node-configure</h3>
<p>munin-node-configure is really useful command you can use it install all the plugins you need, when you run it will try to test if a plugin can be used or not (&#8211;suggest argument), and even give the commands needed to link the plugin automatically (&#8211;shell argument)</p>
<pre>
sudo munin-node-configure --suggest
sudo munin-node-configure --shell
</pre>
<h3>MySQL plugin</h3>
<pre>
sudo apt-get install libcache-perl libcache-cache-perl

sudo munin-node-configure --suggest --shell | sh

sudo munin-run mysql_commands 

sudo service munin-node restart
</pre>
<h3>Memcached plugin</h3>
<pre>
sudo aptitude install libcache-memcached-perl

sudo ln -s /usr/share/munin/plugins/memcached_ /etc/munin/plugins/memcached_bytes
sudo ln -s /usr/share/munin/plugins/memcached_ /etc/munin/plugins/memcached_counters
sudo ln -s /usr/share/munin/plugins/memcached_ /etc/munin/plugins/memcached_rates

sudo munin-run memcached_counters 

sudo service munin-node restart
</pre>
<h3>Nginx Web Server</h3>
<p>Configure Nginx to repoer its status under the URL http://localhost/nginx_status, which will be read from Munin Nginx plugin:</p>
<pre>
sudo vi /etc/nginx/sites-enabled/default
server {
:
        # STATUS
        location /nginx_status {
                stub_status on;
                access_log off;
                allow 127.0.0.1;
                allow ::1;
                allow my_ip;
                deny all;
        }
:
}

sudo service nginx restart
</pre>
<p>Configure Munin:</p>
<pre>
sudo apt-get install libwww-perl

sudo ln -s '/usr/share/munin/plugins/nginx_request' '/etc/munin/plugins/nginx_request'
sudo ln -s '/usr/share/munin/plugins/nginx_status' '/etc/munin/plugins/nginx_status'

sudo munin-run nginx_request

sudo service munin-node restart
</pre>
<h3>Postgres</h3>
<p>It is better to use munin-node-configure to configure and install postgres plugin, because it will detect installed databases and configure a graph for each.</p>
<pre>
sudo apt-get install libdbd-pg-perl
sudo munin-node-configure --suggest
sudo sh -c  'munin-node-configure --shell | grep postgres | sh '
sudo service munin-node restart
</pre>
