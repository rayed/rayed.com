---
title: Linux vs FreeBSD kernel rebuild
author: Rayed
type: post
date: 2007-06-10T09:49:16+03:00
categories:
  - UNIX
wordpress_id: 315

---
<p>For the past couple of week, I am trying to refresh my Linux skills, I abandoned Linux as the server platform of choice in favor of <a href="http://www.freebsd.org/">FreeBSD</a>, but recently unfortunately FreeBSD isn&#8217;t supported as Linux, and sometimes Linux have this weired feature that isn&#8217;t available in FreeBSD, e.g. <a href="http://www.drbd.org/">DRDB</a>.</p>
<p>I am big FreeBSD fan, and I loved it even more when I worked with Linux, <a href="http://www.ubuntu.com/">Ubuntu</a>, the Linux distribution I use, is really impressive as a desktop OS, but if you want to hack the system, and play with its internal it doesn&#8217;t give much room, and this the exact reason I switched from Windows to Linux 10 years ago.</p>
<p>What triggered me to write this post is my attempt to rebuild new Linux kernel on Ubuntu, I downloaded the kernel from <a href="http://www.kernel.org/">kernel.org</a> and searched for documentation on how to rebuild 2.6 kernel, and to my surprise there isn&#8217;t any official documentation on that subject and old Kernel-HOWTOs now refer to <a href="http://www.digitalhermit.com/linux/Kernel-Build-HOWTO.html">Kernel Rebuild Guide</a>.</p>
<p>I followed every step and waited to reboot my new kernel, some of the command didn&#8217;t work or have different syntax, and rebooted to get this message &#8220;Fatal error couldn&#8217;t load modules.dep&#8221;, did some Internet search and no one really knows what is the problem. Tried different things, the problem fixed, but I have another problem now, and still didn&#8217;t boot to my new kernel (I still can access my system using the Ubuntu default kernel) &#8230;.</p>
<p>For the past 6 years working with FreeBSD I never had any problems with rebuilding the kernel, all I need to do is this:</p>
<pre>
# cd /usr/src/sys/i386/conf
# cp GENERIC MYKERNEL
# vi MYKERNEL
# cd /usr/src
# make buildkernel KERNCONF=MYKERNEL
# make installkernel KERNCONF=MYKERNEL
</pre>
<p>and it is all documented in the official <a href="http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/">FreeBSD Handbook</a>, and it takes half the time Linux kernel needed to recompile the kernel.</p>
<p>Viva FreeBSD!!</p>
