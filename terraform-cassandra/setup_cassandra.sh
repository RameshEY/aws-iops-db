#!/bin/bash

set -x

function add_cassandra_config_for_data_striping () {
    sudo sed -i "s/\/var\/lib\/cassandra\/data/\/var\/lib\/cassandra\/data\/data1\\
    - \/var\/lib\/cassandra\/data\/data2/g" /etc/cassandra/cassandra.yaml
}

function check_nvme_disks () {
    local NVME_DEVICE_NAME1=/dev/nvme0n1
    local NVME_DEVICE_NAME2=/dev/nvme1n1
    local NVME_DEVICENAME1=`echo $NVME_DEVICE_NAME1 | awk -F '/' '{print $3}'`
    local NVMEDEVICEEXISTS=`lsblk |grep $NVME_DEVICENAME1 |wc -l`
    if [[ $NVMEDEVICEEXISTS == "1" ]]; then
       add_cassandra_config_for_data_striping
    fi
}

sudo service cassandra stop
sudo rm -Rf /var/lib/cassandra/data/system/* /var/log/cassandra/*
sudo cp -f /etc/cassandra/cassandra.yaml /etc/cassandra/cassandra.yaml.backup
sudo cp -f /tmp/provisioning/cassandra.yaml /etc/cassandra/cassandra.yaml
check_nvme_disks
sudo cp -f /etc/cassandra/jvm.options /etc/cassandra/jvm.options.backup
sudo cp -f /tmp/provisioning/jvm.options /etc/cassandra/jvm.options
sudo service cassandra start

sleep 60
private_ip=$(hostname -I)
nodetool -h ${private_ip} status
cat /tmp/provisioning/init_cassandra.cql | cqlsh ${private_ip}
cqlsh ${private_ip} -e "describe keyspace ycsb"
