---
title: Enabling FreeBSD firewall
author: Rayed
type: post
date: 2004-11-28T09:06:23+03:00
categories:
  - UNIX
wordpress_id: 70

---
<p>Now with the new FreeBSD releases you don&#8217;t have to recompile the kernel to add firewall support (which is easy but take sometime), now firewall module can be loaded as a kernel module, with a simple command like:<br />
<code><br />
# kldload ipfw        # (WARNING read on first)<br />
</code></p>
<p>But be careful the default behaviour is to block everything, you need to open the connection you need manually using a command like:<br />
<code><br />
# ipfw -q add allow all from any to any<br />
</code></p>
<p>The first time I tried it I lost my ssh connection.</p>
<p>Fortunately the machine was next to me, so I logged on using the console, and unloaded the module:<br />
<code># kldunload ipfw</code></p>
<p>I never worked with kernel modules with FreeBSD, this another useful command, to list the loaded modules you can use:<br />
<code># kldstat</code></p>
<p>Note: This feature is little old, since 4.6</p>
