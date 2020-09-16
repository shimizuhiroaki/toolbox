#!/bin/bash

### install needs ###
echo "Install standard Tools"
apt install unzip htop expect git iftop iotop dstat lv net-tools arping nkf unzip dnsutils vim telnet

### disable service ###
echo "stop and disable apparmor"
systemctl stop apparmor.service
systemctl disable apparmor.service


### Vim ###
VIM_FILE=/etc/vim/vimrc.local
echo "Set Vim Setting"
echo "syntax on" >> $VIM_FILE
echo "set nobackup" >> $VIM_FILE
echo "set fileencoding=japan" >> $VIM_FILE
echo "set fileencodings=utf-8,iso-2022-jp,ucs2le,ucs-2,cp932" >> $VIM_FILE
update-alternatives --config editor

### install alp ###
echo "Install alp"
cd /usr/local/src/
#wget -d https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
wget -d https://github.com/tkuchiki/alp/releases/download/v1.0.3/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
mv alp /usr/local/bin/

### Install netdata ###
apt install netdata
sed -i -e "s/bind socket to IP = 127.0.0.1/bind socket to IP = 0.0.0.0/" /etc/netdata/netdata.conf
systemctl restart netdata

### Install Mysql Tools ###
echo "install percona"
apt install percona-toolkit

echo "install mysqltuner"
apt install mysqltuner

### disable unneed processes ###
#systemctl disable iscsid
#systemctl disable lvm2-lvmetad
#systemctl disable mdadm
#systemctl disable snapd

exit 0
