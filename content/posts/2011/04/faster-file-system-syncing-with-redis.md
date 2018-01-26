---
title: Faster file syncing with Redis
author: Rayed
type: post
date: 2011-04-03T19:01:44+03:00
categories:
  - Uncategorized
tags:
  - alriyadh.com
  - cms
  - messaging
  - PHP
  - python
  - redis
  - rsync
wordpress_id: 819

---
<p><strong>The problem</strong><br />
In <a href="http://www.alriyadh.com/">alriyadh.com</a> most of the site administration take place inside the premises of Alriyadh Newspaper offices, and as you can image the bandwidth dedicated to the website team isn&#8217;t that big. This why we designed our system to have two parts, one inside Alriyadh Newspaper internal data center where the local access is very fast, and another part accessible to the public hosted in MeduNet, and we would have a database replication for the website data, and file system replication for the web site images and media.</p>
<p><strong>Current Solution</strong><br />
MySQL replication is straight forward and very easy to setup, and since we are mostly replicating textual data, the replication is relatively fast and reliable, given that you have a reliable Internet connectivity.</p>
<p>For images replication we used &#8220;rsync&#8221; that run from a cron job, rsync is very efficient with bandwidth consumption, but it had to a scan a large number of directories to see which files aren&#8217;t synced, and this usually very slow process, and this why it would take couple of minutes for some images to appear.</p>
<p><strong>Redis to the rescue</strong><br />
<a href="http://redis.io/">Redis</a> is key-value store, it is similar to <a href="http://memcached.org/">memcached</a> in many ways, especially being super fast and very suitable for caching, it also have tons of extra features that makes it really interesting.</p>
<p>The feature that caught my eyes is &#8220;Publish/Subscribe&#8221;, basically a client would &#8220;publish&#8221; a message to a given channel, and all other client who &#8220;subscribed&#8221; to the same channel would receive the message, if no one &#8220;subscribed&#8221; no harm is done and the publishing succeeded, if multiple client &#8220;subscribed&#8221; they will all get a copy of the message.</p>
<p>The plan was to have the CMS (written in PHP) publish a message with a name of any file changed, and fast_sync daemon (written in Python) would collect these files and copy them individually using &#8220;rsync&#8221; to the remote server, instead of syncing a whole directory.</p>
<p><strong>Conclusion</strong><br />
faster file system syncing of course &#8230; you forgot the title already!<br />
Seriously, the file syncing now takes few seconds, instead of couple of minutes or more, we could also do image thumbnail generation before syncing inside fast_sync daemon, and if everything fails we still have cron+rsync</p>
<p><strong>Code</strong><br />
From CMS in PHP, this should be integrated into the CMS file manipulation code:</p>
<pre>
< ?php
$r = new Redis();
$r->connect('127.0.0.1', 6379, 0.5);
$r->publish("new_files", "/path/to/www/htdocs/img/test.jpg");
?>
</pre>
<p>&#8220;fast_sync&#8221; in &#8220;Python&#8221;, this should run all the time, may be start it using &#8220;nohup fast_sync.py &#038;&#8221;</p>
<pre>
#!/usr/local/bin/python -u

import redis
import time
import thread
import os


files = []
lock = thread.allocate_lock()


def send_files():
    global files, lock

    while 1:
        lock.acquire()
        my_files = list(files)
        del files[:]
        lock.release()
        if len(my_files) > 0:
            command="rsync -azv %s www:/path/to/www" % (" ".join(my_files))
            os.system(command)

        time.sleep(2)


def main():
    global files, lock, base

    # Start file sending thread
    thread.start_new_thread(send_files, ())

    # Start redis queue listener
    files = []
    r = redis.Redis(host='localhost', port=6379, db=0)
    r.subscribe("new_files")
    for msg in r.listen():
        # add file to sending queue
        if msg["type"] != "message": continue
        file = msg["data"]
        print "LISTENER: Adding ", file
        lock.acquire()
        files.append(file)
        lock.release()
        time.sleep(.1)

if __name__ == "__main__":
    try: main()
    except KeyboardInterrupt: print "Stopped by user"
</pre>
