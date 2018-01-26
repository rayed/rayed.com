---
title: alriyadh.com migration status
author: Rayed
type: post
date: 2006-02-23T22:53:06+03:00
categories:
  - alriyadh.com
  - UNIX
wordpress_id: 211

---
<p>Alriyadh.com is hosted at <a href="http://www.medu.net.sa/">MeduNet</a>, they unpacked the servers on the lab for now, and hopefully they will prepare the racks and install the servers next week.<br />
Mean while I went to MeduNet and installed <a href="http://www.freebsd.org/">FreeBSD 6</a> on the 3 servers, fortunately I brought 2 installation CD with me which allowed me to work on 2 servers concurrently. The whole installation process took 1 hour for the 3 servers, of course this a basic setup to allow me to connect remotely to continue installing required software.<br />
I went back home and continued working on the servers, it took more than 7 hours to update the system and install the required software, specially <a href="http://cricket.sourceforge.net/">Cricket</a> which required a lot of time and configuration.<br />
I also started migrating some of the data from the old servers to the new ones, and to tell you the truth the link between those servers are extremely slow, I left rsync running for overnight and it only copied 1.7G out of 10G.</p>
