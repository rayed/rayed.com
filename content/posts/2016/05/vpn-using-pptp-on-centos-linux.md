---
title: VPN using PPTP on CentOS Linux
author: Rayed
type: post
date: 2016-05-10T15:15:16+03:00
draft: true
private: true
categories:
  - Uncategorized
tags:
  - linux
  - pptp
  - security
wordpress_id: 1915

---
<h2>Install, Configure PPTP</h2>
<p><code></p>
<pre>
sudo yum install pptpd -y
sudo echo "localip 10.0.0.1" >> /etc/pptpd.conf
sudo echo "remoteip 10.0.0.100-200" >> /etc/pptpd.conf
sudo echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd
sudo echo "ms-dns 8.8.4.4" >> /etc/ppp/options.pptpd
sudo echo "rayed           pptpd   clear-text-password     *"  >> /etc/ppp/chap-secrets
sudo systemctl enable pptpd 
sudo systemctl start pptpd 
</pre>
<p></code></p>
<h2>Enable Network Forwarding</h2>
<p><code></p>
<pre>
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo sysctl -p
</pre>
<p></code></p>
<h2>Open Firewall for PPTP traffic + NATing</h2>
<p><code></p>
<pre>
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -i eth0 -p tcp --dport 1723 -j ACCEPT 
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT 
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter POSTROUTING 0 -t nat -o eth0 -j MASQUERADE 
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i ppp+ -o eth0 -j ACCEPT 
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i eth0 -o ppp+ -j ACCEPT
sudo firewall-cmd --reload
</pre>
<p></code></p>
