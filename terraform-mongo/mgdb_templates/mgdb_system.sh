#!/bin/bash

set -x

#
# file: mgdb_system.sh
# description: linux system and filesystem setup for mongodb
#

mkdir -p /opt
mount /dev/${DEVICE_NAME} /opt
echo '/dev/${DEVICE_NAME} /opt xfs defaults 0 0' | sudo tee -a /etc/fstab

#
# tuning for mongo
#

echo LC_ALL=\"en_US.UTF-8\" >> /etc/default/locale

# kernel tuning recommended by MongoDB
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo noop > /sys/block/${DEVICE_NAME}/queue/scheduler
touch /var/lock/subsys/local
echo 0 > /sys/class/block/${DEVICE_NAME}/queue/rotational
echo 8 > /sys/class/block/${DEVICE_NAME}/queue/read_ahead_kb

# virtual memory tuning
#dirty ratio  and dirtybackground ratio change
#vm.swapiness=0
#filesytem changes suggested
#enable the deadline scheduler
#Make the readahead to 8K
#echo noop > /sys/block/${DEVICE_NAME}/queue/scheduler
#touch /var/lock/subsys/local
#echo 0 > /sys/class/block/${DEVICE_NAME}/queue/rotational
#echo 8 > /sys/class/block/${DEVICE_NAME}/queue/read_ahead_kb
#Start the mongodb using interleaved-mode numactl--interleave=all in the mongodb.conf file

# shorter keepalives, 120s recommended for MongoDB in official docs:
# https://docs.mongodb.org/manual/faq/diagnostics/#does-tcp-keepalive-time-affect-mongodb-deployments
# sysctl -w net.ipv4.tcp_keepalive_time=120
# cat << EOF > /etc/sysctl.conf
# net.ipv4.tcp_keepalive_time = 120
# fs.file-max = 65536
# vm.dirty_ratio=15
# vm.dirty_background_ratio=5
# vm.swapiness=0
# vm.zone_reclaim_mode = 0
#EOF
#sysctl -p

# MongoDB prefers file limits > 20,000
cat << EOF > /etc/security/limits.conf
* soft     nproc          65535
* hard     nproc          65535
* soft     nofile         65535
* hard     nofile         65535
EOF
