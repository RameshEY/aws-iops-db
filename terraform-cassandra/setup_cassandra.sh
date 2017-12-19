#!/bin/bash

set -x

sudo service cassandra stop
sudo rm -Rf /var/lib/cassandra/* /var/log/cassandra/*
sudo cp -f /tmp/provisioning/cassandra.yaml /etc/cassandra/cassandra.yaml
sudo service cassandra start

private_ip=$(hostname -I)
nodetool -h ${private_ip} status
sleep 60
cat /tmp/provisioning/init_cassandra.cql | cqlsh ${private_ip}
cqlsh ${private_ip} -e "describe keyspace ycsb"
