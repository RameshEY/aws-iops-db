export TF_VAR_ycsb_aws_access_key=${AWS_ACCESS_KEY}
export TF_VAR_ycsb_aws_secret_key=${AWS_SECRET_KEY}

export TF_VAR_ycsb_vpc_id=${iopstest_vpc_id}
export TF_VAR_ycsb_subnet_id=${iopstest_subnet_id}
export TF_VAR_ycsb_aws_region=${iopstest_aws_region}
export TF_VAR_ycsb_key_name=${iopstest_key_name}
export TF_VAR_ycsb_key_path=${iopstest_key_path}

export TF_VAR_ycsb_instance_name="${iopstest_owner}-iopstest-ycsb"
export TF_VAR_ycsb_security_group_name="${iopstest_owner}-iopstest-ycsb"

