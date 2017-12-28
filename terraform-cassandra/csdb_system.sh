#!/bin/bash

#
# file: csdb_system.sh
# description: configures the linux system for cassandra
#

set -x

lsblk | grep nvme 2>&1 > /dev/null
is_nvme=$?

if [[ $is_nvme == 0 ]]; then

  sudo mkfs -t xfs /dev/nvme0n1
  sudo mkfs -t xfs /dev/nvme1n1

  sudo mkdir -p /var/lib/cassandra/data/data1
  sudo mkdir -p /var/lib/cassandra/data/data2

  sudo mount /dev/nvme0n1 /var/lib/cassandra/data/data1
  sudo mount /dev/nvme1n1 /var/lib/cassandra/data/data2	

  sudo echo '/dev/nvme0n1 /var/lib/cassandra/data/data1 xfs defaults 0 0' | sudo tee -a /etc/fstab
  sudo echo '/dev/nvme1n1 /var/lib/cassandra/data/data2 xfs defaults 0 0' | sudo tee -a /etc/fstab

else

  sudo mkdir -p /var/lib/cassandra/data

  sudo mount /dev/xvdh /var/lib/cassandra/data
  echo '/dev/xvdh /var/lib/cassandra xfs defaults 0 0' | sudo tee -a /etc/fstab

fi

lsblk -f  # report mounted block devices
