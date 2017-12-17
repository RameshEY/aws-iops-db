#!/bin/bash

set -x

sudo apt-get update
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
apt_source='deb http://repos.azulsystems.com/debian stable main'
apt_list='/etc/apt/sources.list.d/zulu.list'
echo "$apt_source" | sudo tee "$apt_list" > /dev/null
sudo apt-get update
sudo apt-get install -y zulu-8
sudo apt-get install -y python-pip
sudo pip install cassandra-driver
echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y gcc libev4 libev-dev python-dev
sudo apt-get install -y dsc30 -V
sudo apt-get install -y cassandra-tools
sudo service cassandra stop
sudo rm -rf /var/lib/cassandra/data/system/*

sudo pip install cqlsh
