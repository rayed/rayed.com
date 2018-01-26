---
title: Graph you Data and Email It
author: Rayed
type: post
date: 2014-03-26T11:11:52+03:00
categories:
  - Uncategorized
tags:
  - email
  - gnuplot
  - graph
  - plot
wordpress_id: 1574

---
<p>I have a new website and I want to know the number of new signup every day, so I wrote a small script <code>new_users.sh</code> that will print the number of new signups today.</p>
<p><code></p>
<pre>$ new_users.sh
280
</pre>
<p></code></p>
<p>I ran this script daily using a cron job and add it to user.dat file:<br />
<code></p>
<pre>
0 0 * * *   /home/rayed/bin/new_users.sh >> /home/rayed/var/user.dat
</pre>
<p></code></p>
<p>After few days the file will look like this:</p>
<p><code></p>
<pre>#Users
50
104
202
298
290
289
291
310
311
280
</pre>
<p></code></p>
<p>I could send this file daily and read, but it wouldn&#8217;t give a good picture of how new user signup is changing by time, so the next logical step is to convert it to a graph for easier understanding.</p>
<p>I used <strong>gnuplot</strong> to convert the textual data to a graph, and automatically email it to me.</p>
<p>So I wrote the following small script, <strong>email_graph.sh</strong>:<br />
<code></p>
<pre>#!/bin/sh

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

from_email="rayed@example.com"
to_email="rayed@example.com"

plot="
set terminal png \
    medium \
    size 800,400;
plot  'user.dat' with lines;
"

img_base64=`echo $plot | gnuplot | base64`

sendmail $to_email &lt;&lt;EOF
From: &lt;$from_email&gt;
To: &lt;$to_email&gt;
Subject: Plot and Inline image from CLI
Mime-Version: 1.0
Content-Type: multipart/related; boundary="boundary-example"; type="text/html"

--boundary-example
Content-Type: text/html; charset="US-ASCII"

This email sent from Linux CLI:
&lt;br&gt;
&lt;IMG SRC="cid:plot_image_1" ALT="Plot"&gt;

--boundary-example
Content-ID: &lt;plot_image_1&gt;
Content-Type: IMAGE/PNG
Content-Transfer-Encoding: BASE64

$img_base64

--boundary-example--
EOF
</pre>
<p></code></p>
<p>When you run it you will receive the following graph on your email:</p>
<p><img src="http://rayed.com/wordpress/wp-content/uploads/2014/03/noname.png" alt="plot" width="500" height="300" class="alignnone size-full wp-image-1580" srcset="https://rayed.com/wordpress/wp-content/uploads/2014/03/noname.png 500w, https://rayed.com/wordpress/wp-content/uploads/2014/03/noname-300x180.png 300w" sizes="(max-width: 500px) 100vw, 500px" /></p>
<p>Of course you can edit the email HTML template, add new graph, or do whatever you like to customise it.</p>
<p>I hope you find it useful.</p>
<p>Side note to self:<br />
To install gnuplot with X11 support on OSX:<br />
<code></p>
<pre>brew install gnuplot --with-x</pre>
<p></code></p>
