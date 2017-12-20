#!/bin/bash

set -x

#
# File: ycsb_run_test.sh
# Description: provided by terraform-mongodb, provisioned by terraform-ycsb
#
# Todo:
#   * make the mongodb database name randomize
#   * update this example ycsb command to a real one based on test strategy
#


datatase_private_id=$1

sleep 10

ycsb load mongodb -s \
   -p mongodb.url="mongodb://${datatase_private_id}:27017/ycsb" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/workloada \
   -p recordcount=1000 -threads 16 \
   -p mongodb.auth="false" 
