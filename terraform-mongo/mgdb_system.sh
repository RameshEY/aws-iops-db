#!/bin/bash

#
# file: mgdb_system.sh
# description: linux system and filesystem setup for mongodb
#

set -x

mkdir -p /opt

device_name=xvdh
if [[ -b /dev/nvme0n1 ]]; then

   device_name=nvme0n1

# 12/27/17 mkfs on /dev/md0 takes way too long to finish
#  if [[ ! -b /dev/md0 ]]; then
#     DEBIAN_FRONTEND=noninteractive apt-get install -y mdadm
#     mdadm --create --verbose /dev/md0 --level=0 --name=opt --raid-devices=2 /dev/nvme0n1 /dev/nvme1n1
#     #mkfs -t xfs /dev/md0
#     mount /dev/md0 /opt
#     echo '/dev/md0 /opt xfs defaults 0 0' | sudo tee -a /etc/fstab
#     device_name=md0
#  fi

fi

mount /dev/${device_name} /opt
echo "/dev/${device_name} /opt xfs defaults 0 0" | sudo tee -a /etc/fstab

#
# tuning for mongo
#

echo LC_ALL=\"en_US.UTF-8\" >> /etc/default/locale

# kernel tuning recommended by MongoDB
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo noop > /sys/block/${device_name}/queue/scheduler
touch /var/lock/subsys/local
echo 0 > /sys/class/block/${device_name}/queue/rotational
echo 8 > /sys/class/block/${device_name}/queue/read_ahead_kb

# virtual memory tuning
#dirty ratio  and dirtybackground ratio change
#vm.swapiness=0
#filesytem changes suggested
#enable the deadline scheduler
#Make the readahead to 8K
#echo noop > /sys/block/${device_name}/queue/scheduler
#touch /var/lock/subsys/local
#echo 0 > /sys/class/block/${device_name}/queue/rotational
#echo 8 > /sys/class/block/${device_name}/queue/read_ahead_kb
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
