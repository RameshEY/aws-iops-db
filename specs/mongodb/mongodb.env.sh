export TF_VAR_mgdb_user_name="ubuntu"
export TF_VAR_mgdb_key_name=${iopstest_key_name}
export TF_VAR_mgdb_key_path=${iopstest_key_path}

export TF_VAR_mgdb_aws_region=${iopstest_aws_region}
export TF_VAR_mgdb_instance_name="${iopstest_owner}-iopstest-mongodb"
export TF_VAR_mgdb_security_group_name="${iopstest_owner}-iopstest-mongodb"

export TF_VAR_mgdb_vpc_id=${iopstest_vpc_id}
export TF_VAR_mgdb_subnet_id=${iopstest_subnet_id}
