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
desired_workload=$2

function check_readiness {
   true;
}

check_readiness;

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export YCSB_HOME=/home/ubuntu/ycsb-0.12.0

ycsb load cassandra-cql -s \
   -p hosts="${datatase_private_id}" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 250

ycsb run cassandra-cql -s \
   -p hosts="${datatase_private_id}" \
   -P /home/ubuntu/ycsb-0.12.0/workloads/$desired_workload \
   -threads 250
