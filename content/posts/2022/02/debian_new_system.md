---
title: "Debian New System Useful Commands"
date: 2022-02-22T14:22:48+03:00
type: post
---


## Update System

    # switch to user root
    su -
    apt update && apt upgrade
    apt install sudo
    usermod -aG sudo rayed 
    # logout from root & user



## Network

### Enable New Interface

Ref: https://wiki.debian.org/NetworkConfiguration

    sudo vi /etc/network/interfaces
    :
    auto enp0s8
    iface enp0s8 inet dhcp
    :
    sudo ifup enp0s8

### NTP

    sudo vi /etc/systemd/timesyncd.conf 
    :
    NTP=sa.pool.ntp.org
    :
    sudo systemctl restart systemd-timesyncd
    timedatectl timesync-status 



## Security

### Secure SSH

    sudo vi /etc/ssh/sshd_config
    :
    PasswordAuthentication no
    :
    sudo systemctl restart ssh

### Firewall

Ref: https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29

    sudo apt install -y ufw
    sudo ufw allow ssh
    sudo ufw enable
    sudo ufw status 

    # Other useful commands
    # sudo ufw app list
    # sudo ufw allow "WWW Full"
    # sudo ufw allow 8080/tcp



## Misc

### Disable VIM mouse integration

Ref: https://unix.stackexchange.com/a/397464

    sudo vi /etc/vim/vimrc.local
    :
    source $VIMRUNTIME/defaults.vim
    let skip_defaults_vim = 1
    set mouse=r
    :

### Change Default Editor

    sudo apt install -y vim
    sudo update-alternatives --set editor /usr/bin/vim.basic

### Change Hostname 

    sudo hostnamectl set-hostname dev1

### Development Tools

    sudo apt install build-essential
    
### Python 3 

    sudo apt install -y python3-venv
    python3 -m venv venv
    . venv/bin/activate
    pip install django
    pip freeze > requirements.txt

### Docker

Ref: https://docs.docker.com/engine/install/debian/

    sudo apt install -y ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io

Test:

    sudo docker run hello-world

Run from non root:

    usermod -aG docker rayed  # logout to take effect
    docker run hello-world