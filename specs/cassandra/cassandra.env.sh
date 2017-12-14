export TF_VAR_csdb_aws_access_key=${AWS_ACCESS_KEY_ID}
export TF_VAR_csdb_aws_secret_key=${AWS_SECRET_ACCESS_KEY}
export TF_VAR_csdb_aws_region="us-east-1"

export TF_VAR_csdb_user_name="ubuntu"
export TF_VAR_csdb_key_name=${iopstest_key_name}
export TF_VAR_csdb_key_path=${iopstest_key_path}
export TF_VAR_csdb_instance_name="${iopstest_owner}-iopstest-cassandra"
export TF_VAR_csdb_ami="ami-da05a4a0"
export TF_VAR_csdb_vpc_id=${iopstest_vpc_id}
export TF_VAR_csdb_subnet_id=${iopstest_subnet_id}

export TF_VAR_csdb_security_group_name="${iopstest_owner}-iopstest-cassandra"

# machine config
export TF_VAR_csdb_root_block_size=8
export TF_VAR_csdb_root_block_type="gp2"
export TF_VAR_csdb_avail_zone="us-east-1a"
export TF_VAR_csdb_instance_type="r4.4xlarge"
export TF_VAR_csdb_ebs_volume_size=1000
export TF_VAR_csdb_ebs_iops=10000
export TF_VAR_csdb_ebs_type="io1"
export TF_VAR_csdb_ebs_device_name="/dev/xvdh"
