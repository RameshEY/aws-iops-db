#!/bin/bash

#create and mount the /var/lib/cassandra/data directory
#NVME_DEVICE* is for the i3.4xlarge instance type
#if $NVME_DEVICE_NAME or $DEVICE_NAME is available, create fs and mount that volume for /var/lib/cassandra
#otherwise, /var/lib/cassandra uses the default root disk
echo "Creating fs and mounting"
sudo mkdir -p /var/lib/cassandra/data
DEVICE_NAME=/dev/xvdh
NVME_DEVICE_NAME1=/dev/nvme0n1
NVME_DEVICE_NAME2=/dev/nvme1n1
NVME_DEVICENAME1=`echo $NVME_DEVICE_NAME1 | awk -F '/' '{print $3}'`
NVMEDEVICEEXISTS=`lsblk |grep $NVME_DEVICENAME1 |wc -l`
if [[ $NVMEDEVICEEXISTS == "1" ]]; then
  sudo mkfs.xfs $NVME_DEVICE_NAME1
  sudo mount $NVME_DEVICE_NAME1 /var/lib/cassandra/data
  sudo echo '/dev/nvme0n1 /var/lib/cassandra/data xfs defaults 0 0' >> /etc/fstab
  sudo mkfs.xfs $NVME_DEVICE_NAME2
else
  DEVICENAME=`echo $DEVICE_NAME | awk -F '/' '{print $3}'`
  DEVICEEXISTS=`lsblk |grep $DEVICENAME |wc -l`
  if [[ $DEVICEEXISTS == "1" ]]; then
    sudo mkfs.xfs $DEVICE_NAME
    sudo mount $DEVICE_NAME /var/lib/cassandra/data
    sudo echo '/dev/xvdh /var/lib/cassandra/data xfs defaults 0 0' >> /etc/fstab
  fi
fi
echo "Done creating fs and mounting"
sudo apt-get update
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
apt_source='deb http://repos.azulsystems.com/debian stable main'
apt_list='/etc/apt/sources.list.d/zulu.list'
echo "$apt_source" | sudo tee "$apt_list" > /dev/null
sudo apt-get update
sudo apt-get install -y zulu-8
sudo apt-get install -y python-pip
sudo pip install cassandra-driver

echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
sudo apt-get update
sudo apt-key adv --keyserver pool.sks-keyservers.net --recv-key A278B781FE4B2BDA
sudo apt-get install -y cassandra
sudo apt-get install -y cassandra-tools
sudo service cassandra stop
sudo rm -rf /var/lib/cassandra/data/system/*
node=$1
if [ -z "${node}" ]; then
    echo "Set to one node cluster by default, since the node parameter did not specify"
    node=0
fi
HELPMSG="The node id must be an integer between 0 and 2"
if [ $node == "0" ]; then
    sudo sed -i "s/cluster_name: 'Test Cluster'/cluster_name: 'kliu_cassandra_cluster'/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/seeds: \"127.0.0.1\"/seeds: \"10.2.5.170\"/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/listen_address: localhost/listen_address:/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/rpc_address: localhost/rpc_address: 0.0.0.0/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/# broadcast_rpc_address: 1.2.3.4/broadcast_rpc_address: 10.2.5.170/g" /etc/cassandra/cassandra.yaml
elif [ $node = "1" ]; then
    sudo sed -i "s/cluster_name: 'Test Cluster'/cluster_name: 'kliu_cassandra_cluster'/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/seeds: \"127.0.0.1\"/seeds: \"i10.2.5.170,10.2.5.171\"/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/listen_address: localhost/listen_address:/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/rpc_address: localhost/rpc_address: 0.0.0.0/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/# broadcast_rpc_address: 1.2.3.4/broadcast_rpc_address: 10.2.5.171/g" /etc/cassandra/cassandra.yaml
elif [ $node = "2" ]; then
    sudo sed -i "s/cluster_name: 'Test Cluster'/cluster_name: 'kliu_cassandra_cluster'/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/seeds: \"127.0.0.1\"/seeds: \"10.2.5.170,10.2.5.171,10.2.5.172\"/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/listen_address: localhost/listen_address:/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/rpc_address: localhost/rpc_address: 0.0.0.0/g" /etc/cassandra/cassandra.yaml
    sudo sed -i "s/# broadcast_rpc_address: 1.2.3.4/broadcast_rpc_address: 10.2.5.172/g" /etc/cassandra/cassandra.yaml
else
    echo "$HELPMSG"
    exit 1
fi
sudo service cassandra start
