#!/bin/sh
# Linux kernel network options for benchmarks
# these aren't necessary safe for production environments
sudo sysctl -p - <<EOF
net.ipv4.tcp_fin_timeout = 25
net.ipv4.tcp_keepalive_time=60
net.ipv4.tcp_keepalive_probes=3
net.ipv4.tcp_keepalive_intvl=15
net.ipv4.tcp_max_syn_backlog=65535
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_tw_recycle=1
net.core.netdev_max_backlog = 2500
net.core.somaxconn=65535
kernel.shmmax=134217728
kernel.shmall=2097152
net.ipv4.ip_local_port_range = 18000    65535
vm.swappiness=0
EOF
