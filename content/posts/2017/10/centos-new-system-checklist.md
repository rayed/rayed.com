---
title: CentOS New System Checklist
author: Rayed
type: post
date: 2017-10-12T06:49:22+03:00
categories:
  - Uncategorized
tags:
  - centos
  - linux
  - virtualbox
wordpress_id: 2046

---
<p>Here I document minimal steps to setup a CentOS 7 machine, it suppose to be a live post, so I&#8217;ll keep updating it every time I found a step worth mentioning!</p>
<p><!--more--></p>
<p><code><br />
################################################<br />
# Add Admin User<br />
################################################</p>
<p># From root<br />
adduser myuser -G wheel<br />
passwd myuser</p>
<p># ... logout from root and login to new user<br />
# Copy your key first:<br />
# ssh-copy-id myuser@10.0.0.19</p>
<p>################################################<br />
# Network<br />
################################################</p>
<p># Find out your network interface name<br />
ip addr </p>
<p># Bring it up and make sure network is working<br />
sudo ifup enp0s3</p>
<p># Configure it to work after reboot<br />
sudo vi /etc/sysconfig/network-scripts/ifcfg-enp0s3<br />
:<br />
ONBOOT=yes</p>
<p>################################################<br />
# Update the System<br />
################################################</p>
<p># Exclude mirrors from slow countries<br />
sudo vi /etc/yum/pluginconf.d/fastestmirror.conf<br />
: Add exclude TLD<br />
:<br />
exclude=.it</p>
<p># Update Repo and Installed Apps<br />
sudo yum -y update</p>
<p># Enable EPEL repo (Extra Packages for Enterprise Linux)<br />
sudo yum -y install epel-release</p>
<p>################################################<br />
# Hostname<br />
################################################</p>
<p>sudo vi /etc/sysconfig/network<br />
: Add your hostname<br />
:<br />
HOSTNAME=node1.example.com<br />
:</p>
<p>sudo vi /etc/hosts<br />
: Add the following (use your real IP):<br />
:<br />
192.168.1.2	node1  node1.example.com</p>
<p>sudo hostname node1.example.com</p>
<p>################################################<br />
# Time and Timezone<br />
################################################</p>
<p># Update Time<br />
sudo yum -y install ntpdate  ntp<br />
sudo ntpdate pool.ntp.org<br />
sudo timedatectl set-timezone Asia/Riyadh</p>
<p>################################################<br />
# SSH Server<br />
################################################</p>
<p>sudo vi /etc/ssh/sshd_config<br />
: Override the following settings<br />
:<br />
UseDNS no<br />
PasswordAuthentication no   #### COPY YOUR PUBLIC KEY FIRST ####<br />
PermitRootLogin no</p>
<p>sudo systemctl restart sshd</p>
<p>################################################<br />
# Development Packages<br />
################################################</p>
<p># if you are going to use it for development<br />
sudo yum -y groupinstall "Development Tools"<br />
</code></p>
