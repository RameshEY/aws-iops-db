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


datatase_private_id=$1

sleep 10

ycsb load cassandra-cql  -s \
   -p hosts="${datatase_private_id}" \
   -p cassandra.readconsistencylevel=QUOROM \
   -p cassandra.writeconsistencylevel=QUOROM \
   -P /home/ubuntu/ycsb-0.12.0/workloads/workloada \
   -threads 16 
