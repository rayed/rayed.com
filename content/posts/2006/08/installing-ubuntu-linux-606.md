---
title: Installing Ubuntu Linux 6.06
author: Rayed
type: post
date: 2006-08-15T01:23:08+03:00
categories:
  - Life
  - UNIX
wordpress_id: 259

---
<p><a href="http://ubuntu.com/"><img src="/upload/2006-08-15/ubuntu.png" alt="Ubuntu Logo" align="right" /></a></p>
<p>Today I installed the new <a href="http://www.ubuntu.com/">Ubuntu</a> 6.06 on my laptop, and I wanted to share my experince.</p>
<p>I took me a while to find out how to install it, after I rebooted from CD, and selected Start/Install a live Ubuntu system showed up, I thought I downloaded the live CD version of Ubuntu, but I remember that I raed &#8220;Install&#8221; during booting, so I rebooted again to try to install the system, same thing happen, I gave up and tried to play with the live CD version, then I found the &#8220;Install Ubuntu&#8221; icon on the desktop!!</p>
<p>The installation was very sweet and straight forward, no messy disk configuration at all, it also include disk partition tool which mean you don&#8217;t have to use partition magic to partition before installing, I didn&#8217;t have to do it any way because I already have partitions ready from older Ubuntu installation.</p>
<p>One of the best part about the installer that it detect my WindowsXP partition, and confiured the boot loader accordingly. I usually get nerveous when I install the boot loaded because if you miss configure it you could lose your Windows boot sector, but Ubuntu handled it without problems.</p>
<p>As soon as I rebooted, it told my that I need to update the system, I clicked the update icon and updating began. It started it slow but it got faster and finished in less than an hour.</p>
<p>Hardware support  in Linux isn&#8217;t a big issue any more and every body expect everything to work and this what happened, Graphic, Network, sound, everything was good and working fine.</p>
<p>My overall impression is good, and if you are looking new challenging task look somewhere else because Ubunti Linux is no brainer, both as a choice and installion, it just work.</p>
<p>Very helpful link if you decided to install Ubuntu:<br />
<a href="http://ubuntuguide.org/">Ubuntu Guide</a></p>
<p><b>Update:</b> Today I installed Ubuntu in my desktop at work (please make sure you backed up your important files first), it took 14 minutes to install, of course the update went much faster 🙂</p>
<p><b>100 Fulldupluex</b><br />
To set 100Mbs Fullduplex I used the following command:<br />
<code><br />
$ sudo mii-tool -F 100baseTx-FD eth0<br />
</code></p>
