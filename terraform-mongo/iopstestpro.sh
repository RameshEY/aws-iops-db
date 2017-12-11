#!/bin/bash

set -x

# AWS Site Variables
export AWS_CONFIG_FILE=...
export AWS_DEFAULT_OUTPUT=json
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY=...
export AWS_SECRET_KEY=...

export TF_VAR_aws_access_key=${AWS_ACCESS_KEY} 
export TF_VAR_aws_secret_key=${AWS_SECRET_KEY} 

export TF_VAR_vpc_id="vpc-ae6425ca"
export TF_VAR_subnet_id="subnet-83d34bdb"
export TF_VAR_aws_region="us-east-1"
export TF_VAR_key_name="kenzan-scratch" 
export TF_VAR_key_path="/Volumes/KNZN/PEM/kenzan-scratch" 

# todo: terraform code should create an YCSB security group for the databases
export TF_VAR_security_group_name="sg-42044237" 
export TF_VAR_instance_name="iopstest-ycsb"

