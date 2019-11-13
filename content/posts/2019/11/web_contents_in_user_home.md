---
title: "SELinux Tip: Web Contents in User Home"
date: 2019-11-12T18:33:00+03:00
type: post
---

I moved my website to new a server, since I moved my blog to [Hugo](https://gohugo.io/) I only needed small machine with minimal spec, so I downgraded my server to one costing $5 per month instead of $10.

I usually put all my personal projects including the blog under my home directory `/home/rayed`, and point the Apache web server to serve content from inside it.

So I configured Apache web server as follow:

    $ sudo vi /etc/httpd/conf.d/rayed.conf 
    :
    DocumentRoot /home/rayed/html
    <Directory /home/rayed/html/>
        Require all granted
        AllowOverride All
    </Directory>
    :

But when I tried to access my website <http://rayed.com/> I got the following error:

    Forbidden
    You don't have permission to access / on this server.

So I checked the permission of the html directory and its parents:

    $ ls -ld /home /home/rayed /home/rayed/html
    drwxr-xr-x.  3 root  root  4096 Nov 10 21:05 /home
    drwxr-xr-x. 12 rayed rayed 4096 Nov 12 18:46 /home/rayed
    drwxr-xr-x.  2 rayed rayed 4096 Nov 12 18:43 /home/rayed/html

Permissions looks fine, so why it isn't working! I checked the log file:

    $ sudo tail -f /var/log/httpd/ssl_error_log
    :
    [core:error] [pid 12345] (13)Permission denied: [client 192.168.10.10] AH00132: file permissions deny server access: /home/rayed/html/index.html
    :

By now I started to suspect SELinux so I checked `/var/log/audit/audit.log`, where
I got a lengthy error:

    $ sudo tail -f /var/log/audit/audit.log
    type=AVC msg=audit(..........): avc:  denied  { read } for  pid=..... comm="httpd" name="index.html" dev="sda" ino=139008 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:user_home_t:s0 .....

Ok, let's examine the directory security context with `-Z` option in `ls`:

    $ ls -lZ /home/rayed/html
    drwxr-xr-x. rayed rayed unconfined_u:object_r:user_home_t:s0 /home/rayed/html

But this different from the security context of default webserver content files:

    $ ls -ldZ /var/www/html
    drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 /var/www/html

My directory has **user_home_t** and Apaches **httpd_sys_content_t**, so I need to change!

Let's try changing the security context with `chcon` command:

    chcon -Rv --type=httpd_sys_content_t /home/rayed/html

It worked!


## Bonus Command

If you want to change the default security context you can use `semanage` command:

    yum install -y policycoreutils-python
    semanage fcontext -a -t httpd_sys_content_t "/home/rayed/html(/.*)?"
    restorecon -R /home/rayed/html

