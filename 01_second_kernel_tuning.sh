#!/bin/bash
# https://note.com/ujisakura/n/n443807235887
# echo noop > /sys/block/sda/queue/scheduler

KERNEL_FILE="/etc/sysctl.conf"
BACKUP_DATA="/etc/sysctl.data"

sysctl -a > $BACKUP_DATA

echo "net.ipv4.tcp_max_syn_backlog = 2048" >> $KERNEL_FILE
echo "net.core.somaxconn = 2048" >> $KERNEL_FILE
echo "net.core.netdev_max_backlog = 5000" >> $KERNEL_FILE
echo "net.ipv4.tcp_fin_timeout = 30" >> $KERNEL_FILE
echo "net.ipv4.ip_local_port_range = 10240 65535" >> $KERNEL_FILE
echo "net.ipv4.tcp_tw_reuse = 1" >> $KERNEL_FILE
echo "vm.swappiness = 0" >> $KERNEL_FILE
echo "fs.file-max = 600000" >> $KERNEL_FILE
echo "net.core.rmem_max = 16777216" >> $KERNEL_FILE
echo "net.core.rmem_default = 16777216" >> $KERNEL_FILE
echo "net.core.wmem_max = 16777216" >> $KERNEL_FILE
echo "net.core.wmem_default = 16777216" >> $KERNEL_FILE
echo "net.ipv4.tcp_rmem = 4096 12582912 16777216" >> $KERNEL_FILE
echo "net.ipv4.tcp_wmem = 4096 12582912 16777216" >> $KERNEL_FILE
echo "kernel.threads-max = 600000" >> $KERNEL_FILE
echo "kernel.pid_max = 600000" >> $KERNEL_FILE
echo "vm.max_map_count = 1200000" >> $KERNEL_FILE

sysctl -p

exit 0
