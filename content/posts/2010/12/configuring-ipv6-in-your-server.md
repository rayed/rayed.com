---
title: Configuring IPv6 in your server
author: Rayed
type: post
date: 2010-12-25T11:41:30+03:00
categories:
  - Uncategorized
tags:
  - apache
  - ipv6
  - linux
wordpress_id: 802

---
<p>Getting IPv6 connectivity to your server isn&#8217;t very hard in fact if you have a decent provier you might already have it configured.</p>
<h2>Do you have IPv6 already configured?</h2>
<p>First try this command</p>
<pre>
$ ifconfig -a 
</pre>
<p>You will have result like this:</p>
<pre>
eth0      Link encap:Ethernet  HWaddr 00:1e:0b:d6:7b:b8  
          inet addr:88.85.245.43  Bcast:88.85.245.47  Mask:255.255.255.248
          inet6 addr: fe80::21e:bff:fed6:7bb8/64 Scope:Link
          :

he-ipv6   Link encap:IPv6-in-IPv4  
          inet6 addr: 2001:470:1f08:1160::2/64 Scope:Global
          inet6 addr: fe80::5855:f52b/64 Scope:Link
          :

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          :
</pre>
<p>Look for lines starting with &#8220;inet6&#8221;, they indicate IPv6 address, but they have different meaning depend on the scoop.</p>
<h3>Scope:Host</h3>
<p>Scope host means IPv6 is configured in your OS and you can connect to your own machine using IPv6, the address would be &#8220;::1&#8221; which is the equivalent to &#8220;127.0.0.1&#8221; in IPv4 world, try ping to your own machine:</p>
<pre>
$ ping6 ::1
</pre>
<h3>Scope:Link</h3>
<p>Scope Link means IPv6 is configured on the given interface with auto configured &#8220;Link-local addresses&#8221;, in our example &#8220;fe80::21e:bff:fed6:7bb8&#8221; is configured on the interface &#8220;eth0&#8221;.</p>
<p>Have a look at the MAC (HWaddr) address for interface &#8220;eth0&#8221;, and compare it to the IPv6 Link-Local address:</p>
<pre>
00:1e:0b:d6:7b:b8
fe80::21e:bff:fed6:7bb8
</pre>
<p>This is how IPv6 auto configuration works, it generate a unique IPv6 address from you MAC address (insert ff fe in the middle of the mac address).</p>
<p>Link local address are used only inside a LAN, i.e. can&#8217;t be routed from segment to segment, this enable IPv6 machines to communicate without the need for any configuration (you need away to discover IP address for other machines in the LAN of course).</p>
<p>Pinging another machine in LAN using IPv6 would work like this:</p>
<pre>
$ ping6 fe80::21e:bff:fed6:7bb8
connect: Invalid argument
</pre>
<p>It didn&#8217;t work, IPv6 sucks, not really, remember Link Local address can&#8217;t be routed and your OS can&#8217;t use the default gateway to send packets to, this why you have to specify the exact interface you want to use with &#8220;-I&#8221; option, try this:</p>
<pre>
$ ping6 -I eth0 fe80::21e:bff:fed6:7bb8
PING fe80::21e:bff:fed6:7bb8(fe80::21e:bff:fed6:7bb8) from fe80::21e:bff:fed6:7bb8 eth0: 56 data bytes
64 bytes from fe80::21e:bff:fed6:7bb8: icmp_seq=1 ttl=64 time=0.021 ms
64 bytes from fe80::21e:bff:fed6:7bb8: icmp_seq=2 ttl=64 time=0.008 ms
</pre>
<p>That worked fine! </p>
<h3>Scope:Global</h3>
<p>Here&#8217;s where it gets interesting, global address is used to reach other IPv6 network and hosts and they use back to reach you, it can be configured in many ways:</p>
<ul>
<li>Stateless autoconfiguration: the Os will use router discovery packet to build its own IP, using its MAC address again.</li>
<li>DHCPv6 (aka statefull autoconfiguration): same old DHCP update for IPv6.</li>
<li>Manual (aka static configuration)</li>
</ul>
<p>In my server I didn&#8217;t have an IPv6 address, and my provider didn&#8217;t plan to provide it in the near future, so what to do &#8230;. use a tunnel broker to tunnel your IPv6 traffic over IPv4, of course this a temporary solution until my provider arrange for IPv6 upstream connection.</p>
<h2>No IPv6, provider don&#8217;t have IPv6 upstream connection &#8230; tunnel it</h2>
<p>Fortunately the Internet full of free <a href="http://www.google.com/search?q=ipv6+tunnel+broker">IPv6 tunnel broker</a> providers, I signed up with <a href="http://tunnelbroker.net/">Hurricane Electric Free IPv6 Tunnel Broker</a>, after signing up click on &#8220;Create Regular Tunnel&#8221;, it will ask you about your IPv4 address to create the tunnel, and that is it, it will create your tunnel for you, it will even give you steps on how configure it on different OSs.</p>
<p>In my ubuntu server I added the following line to my network configuration file:</p>
<pre>
$ sudo vi /etc/network/interfaces
:
auto he-ipv6
iface he-ipv6 inet6 v4tunnel
     endpoint 216.66.80.26
     address  2001:470:1f08:1160::2
     netmask  64
     up ip -6 route add default dev he-ipv6
     down ip -6 route del default dev he-ipv6
</pre>
<p>and to activate it I ran: </p>
<pre>
sudo ifup he-ipv6
</pre>
<p>and to try it:</p>
<pre>
$ ping6 ipv6.google.com
PING ipv6.google.com(2a00:1450:8006::93) 56 data bytes
64 bytes from 2a00:1450:8006::93: icmp_seq=1 ttl=57 time=97.1 ms
64 bytes from 2a00:1450:8006::93: icmp_seq=2 ttl=57 time=97.2 ms
64 bytes from 2a00:1450:8006::93: icmp_seq=3 ttl=57 time=97.2 ms
64 bytes from 2a00:1450:8006::93: icmp_seq=4 ttl=57 time=97.2 ms
</pre>
<p>IPv6 is configured and working 🙂</p>
<h2>Fun Fact</h2>
<p>HE tunnel broker not only tunnel one IPv6 address they tunnel /64 network to your address, this means you can have 2^64 addresses on this tunnel, in contrast all IPv4 address space is only 2^32 of addresses for the whole world!!!</p>
