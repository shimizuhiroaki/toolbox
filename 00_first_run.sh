#!/bin/bash

### install needs ###
apt install unzip htop expect git iftop iotop dstat lv net-tools arping nkf unzip dnsutils vim telnet

### Vim ###
if [ -e /etc/vim/vimrc.local ]; then
    :
else
    cp vim/vimrc.local /etc/vim/
    update-alternatives --config editor
fi

### install alp ###
cd /usr/local/src/
#wget -d https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
wget -d https://github.com/tkuchiki/alp/releases/download/v1.0.3/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
mv alp /usr/local/bin/

### disable unneed processes ###
#systemctl disable iscsid
#systemctl disable lvm2-lvmetad
#systemctl disable mdadm
#systemctl disable snapd

exit 0
