---
title: Fastest CVS UP server
author: Rayed
type: post
date: 2006-01-21T09:31:38+03:00
categories:
  - UNIX
wordpress_id: 195

---
<p>FreeBSD use a protocol called CVS to update its source code, it is also use it to upgrade FreeBSD ports.<br />
But before you start update you must specify the mirror you want sychronize your code with, of  course you should use the server near you to speed up the process.<br />
I always had trouble finding the best mirror, I used pickup server in France, then I switched to servers in the US, but I never satisfied with the speed.<br />
Until I discovered <a href="http://fastest-cvsup.sourceforge.net/">fastest_cvsup</a> which is a tool that test all mirror of given country(eis) and give the fastest one of them, neat!<br />
It turned out that the fastest mirror are indeede in france, here is the result:<br />
<code><br />
# fastest_cvsup -q -c sa,fr,us,ca<br />
 -=(ooooooooooooooooooooooooooo)=(cvsup2.ca.freebsd.org)=-<br />
cvsup4.fr.freebsd.org<br />
</code><br />
The command check server in Saudi Arabia (nothing in Saudi Arabia but to make sure), France, US, and Canada.<br />
You milage may vary, in fact teh result could change from day to day, so it might be a good idea to use a script like the one given with the tool:<br />
<code><br />
#!/bin/sh<br />
if SERVER=`fastest_cvsup -q -c fr,us,ca`; then<br />
 cvsup -g -L 2 -h $SERVER /usr/local/etc/cvsup/ports-supfile<br />
fi<br />
</code></p>
