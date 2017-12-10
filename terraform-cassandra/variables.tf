variable "access_key" { }
variable "secret_key" { }
variable "ssh_key_path" { }
variable "ssh_key_name" { }
variable "region" { }
variable "user_name" { }
variable "user_prefix" { }
variable "instance_type" { }
variable "ami" { }
variable "ebs_volume_size" { }
variable "avail_zone" { }
variable "ebs_type" { }
variable "ebs_device_name" { }
variable "root_block_size" { }
variable "root_block_type" { }
variable "cidr" { default = "10.2.4.0/23" }
variable "source_cidr_block" { default = ["10.2.5.128/25"] }
variable "cassandra0_ip" { default = "10.2.5.170" }
variable "cassandra1_ip" { default = "10.2.5.171" }
variable "cassandra2_ip" { default = "10.2.5.172" }

#############################################################
#export TF_VAR_access_key=$AWS_ACCESS_KEY_ID
#export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY
#export TF_VAR_ssh_key_name=$KEY_NAME
#export TF_VAR_ssh_key_path=$KEY_PATH
#export TF_VAR_user_name="ubuntu"
#export TF_VAR_region="us-east-1"
#export TF_VAR_avail_zone="us-east-1a"
#export TF_VAR_instance_type="m3.xlarge"
#export TF_VAR_ami="ami-cd0f5cb6"
#export TF_VAR_user_prefix="kliu"
#export TF_VAR_ebs_volume_size=320
#export TF_VAR_ebs_type="gp2"
#export TF_VAR_ebs_device_name="/dev/xvdh"
#export TF_VAR_root_block_size=8
#export TF_VAR_root_block_type="gp2"
#############################################################
