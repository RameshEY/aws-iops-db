variable "csdb_aws_access_key" { }
variable "csdb_aws_secret_key" { }

variable "csdb_vpc_id" { }
variable "csdb_subnet_id" { }
variable "csdb_key_path" { }
variable "csdb_key_name" { }
variable "csdb_aws_region" { }
variable "csdb_user_name" { }
variable "csdb_instance_name" { }
variable "csdb_instance_type" { }
variable "csdb_ami" { }
variable "csdb_security_group_name" { }

variable "csdb_ebs_volume_size" { }
variable "csdb_avail_zone" { }
variable "csdb_ebs_type" { }
variable "csdb_ebs_iops" { }
variable "csdb_ebs_device_name" { }
variable "csdb_root_block_size" { }
variable "csdb_root_block_type" { }
variable "csdb_cidr" { default = "10.2.4.0/23" }
variable "csdb_source_cidr_block" { default = ["10.2.5.128/25"] }

variable "csdb_cassandra0_ip" { default = "10.2.5.170" }
variable "csdb_cassandra1_ip" { default = "10.2.5.171" }
variable "csdb_cassandra2_ip" { default = "10.2.5.172" }

#############################################################
#export TF_VAR_csdb_aws_access_key=$AWS_ACCESS_KEY_ID
#export TF_VAR_csdb_aws_secret_key=$AWS_SECRET_ACCESS_KEY
#export TF_VAR_csdb_ssh_key_name=$KEY_NAME
#export TF_VAR_csdb_ssh_key_path=$KEY_PATH
#export TF_VAR_csdb_user_name="ubuntu"
#export TF_VAR_csdb_aws_region="us-east-1"
#export TF_VAR_csdb_avail_zone="us-east-1a"
#export TF_VAR_csdb_instance_type="r4.4xlarge"
#export TF_VAR_csdb_ami="ami-cd0f5cb6"
#export TF_VAR_csdb_user_prefix="kliu"
#export TF_VAR_csdb_ebs_volume_size=1000
#export TF_VAR_csdb_ebs_type="io1"
#export TF_VAR_csdb_ebs_iops=10000
#export TF_VAR_csdb_ebs_device_name="/dev/xvdh"
#export TF_VAR_csdb_root_block_size=8
#export TF_VAR_csdb_root_block_type="gp2"
#############################################################
