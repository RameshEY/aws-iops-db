#!/bin/bash

set -x

sudo service cassandra stop
sudo rm -Rf /var/lib/cassandra/* /var/log/cassandra/*
sudo cp -f /tmp/provisioning/cassandra.yaml /etc/cassandra/cassandra.yaml
sudo cp -f /tmp/provisioning/cassandra-env.sh /etc/cassandra/cassandra-env.sh
sudo service cassandra start

sleep 60
private_ip=$(hostname -I)
nodetool -h ${private_ip} status
cat /tmp/provisioning/init_cassandra.cql | cqlsh ${private_ip}
cqlsh ${private_ip} -e "describe keyspace ycsb"
