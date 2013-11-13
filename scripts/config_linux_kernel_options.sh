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

# http://fasterdata.es.net/host-tuning/linux/
# increase TCP max buffer size settable using setsockopt()
net.core.rmem_max = 16777216 
net.core.wmem_max = 16777216 
# increase Linux autotuning TCP buffer limit 
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
# increase the length of the processor input queue
net.core.netdev_max_backlog = 30000
# recommended default congestion control is htcp 
net.ipv4.tcp_congestion_control=htcp
# recommended for hosts with jumbo frames enabled
net.ipv4.tcp_mtu_probing=1
EOF
