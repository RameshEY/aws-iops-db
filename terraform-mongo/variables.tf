variable "TF_VAR_name" {}
variable "mongodb_version" {}
variable "mongodb_basedir" {}
variable "mongodb_conf_logpath" {}
variable "mongodb_conf_engine" {}
variable "mongodb_conf_replsetname" {}
variable "mongodb_conf_oplogsizemb" {}
variable "mongodb_key_s3_object" {}
variable "ssl_ca_key_s3_object" {}
variable "ssl_agent_key_s3_object" {}
variable "ssl_mongod_key_s3_object" {}
variable "TF_VAR_opsmanager_key_s3_object" {}
variable "TF_VAR_mongodb_iam_name" {}
variable "TF_VAR_mongodb_sg_id" {}
variable "TF_VAR_vpc_id" {}
variable "TF_VAR_subnet_id" {}
variable "TF_VAR_opsmanager_subdomain" {}
variable "TF_VAR_ebs_volume_id" {}
variable "TF_VAR_route53_zone_id" {}
variable "TF_VAR_route53_hostname" {}
variable "TF_VAR_route53_hostname_internal" {}
variable "TF_VAR_aws_region" {}

variable "ec2_ami_id" {
  default = "ami-fce3c696"
}

variable "ec2_instance_type" {
  default = "m3.xlarge"
}

variable "config_ephemeral" {
  default = "true"
}

variable "config_ebs" {
  default = "false"
}

variable "role_node" {
  default = "false"
}

variable "role_opsmanager" {
  default = "false"
}

variable "role_backup" {
  default = "false"
}

variable "role_arbiter" {
  default = "false"
}

variable "mms_group_id" {
  default = ""
}

variable "mms_api_key" {
  default = ""
}

variable "mms_password" {
  default = ""
}
