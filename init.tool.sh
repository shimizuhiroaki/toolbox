#!/bin/bash

### install alp ###
apt install unzip htop expect git iftop iotop dstat lv net-tools
cd /usr/local/src/
wget -d https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
git clone https://github.com/shimizuhiroaki/toolbox.git
mv alp /usr/local/bin/
