---
title: Installing Fedora Linux on my machine
author: Rayed
type: post
date: 2004-05-22T12:02:30+03:00
categories:
  - Uncategorized
wordpress_id: 26

---
<p><b>What is Fedora?</b><br />
Fedora is basically a hat, see image in <a href="http://images.google.com/images?q=fedora%20&#038;hl=en&#038;lr=&#038;ie=UTF-8&#038;safe=off&#038;sa=N&#038;tab=wi">Google</a><br />
In the computer world Fedora is a new Linux distrbution sponsored by <a href="http://www.redhat.com/">RedHat</a>, and supported by open source community, it existed to replace RedHat free version Linux.</p>
<p><b>Dual booting howto</b></p>
<ul></p>
<li>Using PartitionMagic I resized Windows XP partition, and added two new partitions, 9 GB for Linux, and 1 GB as FAT32 partition, to be shared between Windows XP and Linux.</li>
<li>I installed Linux, with GRUB (boot loader) installed in the partition (and not on MBR).</li>
<li>I rebooted the machine, then from Windows I used <a href="http://www.winimage.com/bootpart.htm">bootpart</a> to add Linux to Windows boot option.</li>
</ul>
