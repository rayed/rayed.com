---
title: "SSH to Virtual Machines"
date: 2018-07-31T17:32:29+03:00
type: post
---

I use VirtualBox a lot during development, create a VM try something, destroy, or abandon it.

I always face a problem connecting to it to from my host machine (e.g. MacOS), you can add a port forwarding to ssh, then add another port for http, then another for DB, and so on.

To solve the forwarding issue, I usually replace the VM network from NAT to "Bridged Network" so my VM can get an IP from my home/work router using DHCP.

I minor problem with this scenario is when you connect to a new network, which will lead to a VM disconnect.

To solve this I switched to "Host-only adapter" this the IP wouldn't change ever, but I would lose the internet connectivity.

So my final solution is to add two network adapters, one "Host-only adapter" for Host to VM connection, and another "NAT" for VM internet connectivity, you can a third "Bridged Network" adapter if you need other machines on your network to access your VM.


p.s. You might need to create new "Host-only network" from VirtualBox settings (not VM setting).

I always add an entry to my ssh config `$HOME/.ssh/config` to connect to my VMs using without checking the hosts file:

    Host vm1
            Hostname 192.168.56.101
            User root
            StrictHostKeyChecking no 
            UserKnownHostsFile /dev/null