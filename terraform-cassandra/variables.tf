variable "access_key" { }
variable "secret_key" { }
variable "ssh_key_path" { }
variable "ssh_key_name" { }
variable "region" { }
variable "user_name" { }
variable "user_prefix" { }
variable "instance_type" { }
variable "security_group_name" { }
variable "ami" { }
variable "ebs_volume_size" { }
variable "avail_zone" { }
variable "ebs_type" { }
variable "cidr" { default = "10.2.4.0/23" }
variable "source_cidr_block" { default = ["10.2.5.128/25"] }
