variable "access_key" { }
variable "secret_key" { }
variable "ssh_key_path" { }
variable "ssh_key_name" { }
variable "region" { }
variable "user_name" { default = "ubuntu" }
variable "user_prefix" { default = "kliu" }
variable "cidr" { default = "10.2.4.0/23" }
variable "instance_type" { default = "m3.large" }
variable "security_group_name" { default = "sg-42044237" }
variable "ami" { default = "ami-cd0f5cb6" }
variable "source_cidr_block" { default = ["10.2.5.128/25"] }
variable "ebs_volume_size" { default = 320 }
