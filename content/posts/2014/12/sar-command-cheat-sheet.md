---
title: “sar” command cheat sheet
author: Rayed
type: post
date: 2014-12-11T13:43:08+03:00
categories:
  - Uncategorized
tags:
  - admin
  - linux
  - monitor
  - top
wordpress_id: 1718

---

"sar" is a Unix command that collect, report, or save system activity information, it is different from other system status command like "top" or "vmstat" that only show real time status only, "sar" in the other hand collect these data so you can find the system state at any time.

<!--more-->

## Options

    # Live values: interval count
    sar 1 3
    # historical values
    sar

### Previous Days

    # Day 11 of current month Ubuntu
    sar -f /var/log/sysstat/sa11
    # Day 11 of current Month CentOS
    sar -f /var/log/sa/sa11

### Time Range

    # show from 10:00 am to 11:00 am
    sar -s 10:00:00 -e 11:00:00

### Data Options

    sar      # CPU 
    sar -r   # RAM
    sar -b   # Disk

### Mixing options

    sar   -b   -s 10:00:00 -e 11:00:00   -f /var/log/sa/sa11  
    -b   # disk 
    -s   # from 10:00 to 11:00
    -f   # day 11


## Installation

### CentOS

    $ sudo yum install sysstat

### Ubuntu

    $ sudo apt-get install sysstat
    $ sudo vi /etc/default/sysstat
    ENABLED=”true”

More info: (http://www.linuxjournal.com/content/sysadmins-toolbox-sar)