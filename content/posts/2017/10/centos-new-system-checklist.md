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
Here I document minimal steps to setup a CentOS 7 machine, it suppose to be a live post, so I'll keep updating it every time I found a step worth mentioning!

<!--more-->


### Add Admin User

    # From root
    adduser myuser -G wheel
    passwd myuser
    # ... logout from root and login to new user
    # Copy your key first:
    # ssh-copy-id myuser@10.0.0.19

### Network

    # Find out your network interface name
    ip addr 
    # Bring it up and make sure network is working
    sudo ifup enp0s3
    # Configure it to work after reboot
    sudo vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
    :
    ONBOOT=yes

### Update the System

    # Exclude mirrors from slow countries
    sudo vi /etc/yum/pluginconf.d/fastestmirror.conf
    : Add exclude TLD
    :
    exclude=.it

### Update Repo and Installed Apps

    sudo yum -y update

### Enable EPEL repo (Extra Packages for Enterprise Linux)

    sudo yum -y install epel-release

### Hostname

    sudo vi /etc/sysconfig/network
    : Add your hostname
    :
    HOSTNAME=node1.example.com
    :
    sudo vi /etc/hosts
    : Add the following (use your real IP):
    :
    192.168.1.2	node1  node1.example.com
    sudo hostname node1.example.com

### Time and Timezone

    # Update Time
    sudo yum -y install ntpdate  ntp
    sudo ntpdate pool.ntp.org
    # Update Timezone 
    sudo timedatectl set-timezone Asia/Riyadh

### SSH Server

    sudo vi /etc/ssh/sshd_config
    : Override the following settings
    :
    UseDNS no
    PasswordAuthentication no   #### COPY YOUR PUBLIC KEY FIRST ####
    PermitRootLogin no
    sudo systemctl restart sshd

### Development Packages

    # if you are going to use it for development
    sudo yum -y groupinstall "Development Tools"
