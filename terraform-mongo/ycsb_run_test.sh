#!/bin/bash

#
# File: ycsb_run_test.sh
# Description: provided by terraform-mongodb, provisioned by terraform-ycsb
#
# Todo:
#   * make the mongodb database name randomize
#   * update this example ycsb command to a real one based on test strategy
#

set -x

datatase_private_id=$1
desired_workload=$2

function check_readiness {

   local is_ready=false
   local is_connected=""

   while [[ $is_ready == false ]]; do
      is_connected=$(nc -zv -w 1 $datatase_private_id 27017 2>&1)
      if [[ "$is_connected" == *succeeded* ]]; then
         is_ready=true
      else
         echo "[$(date -u)] $is_connected"
         echo "[$(date -u)] Waiting 1 second..."
         sleep 1
      fi
   done
}

check_readiness;

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export YCSB_HOME=/home/ubuntu/ycsb-0.12.0

ycsb load mongodb -s \
   -p mongodb.url="mongodb://${datatase_private_id}:27017/ycsb" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 250 \
   -p mongodb.auth="false" 2>&1 | tee ~/ycsb_load_test_250.log

ycsb run mongodb -s \
   -p mongodb.url="mongodb://${datatase_private_id}:27017/ycsb" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 250 \
   -p mongodb.auth="false" 2>&1 | tee ~/ycsb_run_test_250.log

ycsb run mongodb -s \
   -p mongodb.url="mongodb://${datatase_private_id}:27017/ycsb" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 100 \
   -p mongodb.auth="false" 2>&1 | tee ~/ycsb_run_test_100.log
