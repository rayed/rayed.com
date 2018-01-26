---
title: Getting Started with DPDK
author: Rayed
type: post
date: 2016-03-30T18:03:08+03:00
draft: true
private: true
categories:
  - Uncategorized
tags:
  - dev
  - dpdk
  - linux
  - network
wordpress_id: 1895

---
<h2>Requirements</h2>
<p><code><br />
yum group install -y "Development Tools"<br />
yum install -y libpcap-devel wget<br />
</code></p>
<h2>Compile and Install DPDK</h2>
<p><code><br />
wget http://dpdk.org/browse/dpdk/snapshot/dpdk-2.2.0.tar.gz<br />
tar -xzvf dpdk-2.2.0.tar.gz<br />
cd dpdk-2.2.0/<br />
make config T=x86_64-native-linuxapp-gcc<br />
sed -ri 's,(PMD_PCAP=).*,\1y,' build/.config<br />
make<br />
sudo make install   # this will install DPDK under /usr/local/<br />
</code></p>
<h2>System Settings</h2>
<h3>Manual</h3>
<p><code><br />
export RTE_SDK=/usr/local/share/dpdk<br />
mkdir -p /mnt/huge   # ONCE<br />
mount -t hugetlbfs nodev /mnt/huge<br />
echo 64 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages<br />
depmod -a     # ONCE<br />
modprobe uio<br />
modprobe igb_uio<br />
lsmod | grep uio   # confirm both module loaded<br />
</code></p>
<h3>Auto after Reboot</h3>
<p><code><br />
echo "export RTE_SDK=/usr/local/share/dpdk" >  /etc/profile.d/dpdk.sh<br />
echo "nodev /mnt/huge hugetlbfs defaults 0 0" >> /etc/fstab<br />
echo "vm.nr_hugepages=64" >> /etc/sysctl.d/dpdk.conf<br />
echo "modprobe uio" >> /etc/rc.modules<br />
echo "modprobe igb_uio" >> /etc/rc.modules<br />
chmod +x /etc/rc.modules<br />
</code></p>
<h3>DPDK Tools</h3>
<p><code><br />
$RTE_SDK/tools/cpu_layout.py<br />
$RTE_SDK/tools/tools/dpdk_nic_bind.py<br />
$RTE_SDK/tools/setup.py<br />
</code></p>
