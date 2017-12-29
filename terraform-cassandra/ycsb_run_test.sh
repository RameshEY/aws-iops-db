#!/bin/bash

set -x

#
# File: ycsb_run_test.sh
# Description: provided by terraform-cassandra, provisioned by terraform-ycsb
#
# Todo:
#   * make the cassandra database name randomize
#   * update this example ycsb command to a real one based on test strategy
#
#
#   -p cassandra.readconsistencylevel=QUOROM
#   -p cassandra.writeconsistencylevel=QUOROM

sudo apt-get update
sudo apt-get install -y python-pip
sudo pip install cqlsh

database_private_id=$1
desired_workload=$2

function check_readiness {
   local is_ready=false
   local is_connected=""
   while [[ $is_ready == false ]]; do
      is_connected=$(nc -zv -w 1 $database_private_id 9042 2>&1)
      if [[ "$is_connected" == *succeeded* ]]; then
         is_ready=true
      else
         echo "[$(date -u)] $is_connected"
         echo "[$(date -u)] Waiting 5 seconds..."
         sleep 5
      fi
   done
}

function check_keyspace {
   res=`cqlsh ${database_private_id} -e "describe keyspace ycsb" --cqlversion="3.4.4"`
   while [ -z "$res" ]; do
        echo "the keyspace of YCSB is not created yet"
        sleep 5
        res=`cqlsh ${database_private_id} -e "describe keyspace ycsb" --cqlversion="3.4.4"`
   done
}

check_readiness;
check_keyspace;

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export YCSB_HOME=/home/ubuntu/ycsb-0.12.0

ycsb load cassandra-cql  -s \
   -p hosts="${database_private_id}" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 250 2>&1 | tee ~/ycsb_cassandra_load_test_250.log

ycsb run cassandra-cql  -s \
   -p hosts="${database_private_id}" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 100 2>&1 | tee ~/ycsb_cassandra_run_test_100.log

ycsb run cassandra-cql  -s \
   -p hosts="${database_private_id}" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 250 2>&1 | tee ~/ycsb_cassandra_run_test_250.log
