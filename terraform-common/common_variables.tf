variable "common_aws_access_key" { }
variable "common_aws_secret_key" { }

variable "common_aws_amis" { type = "map" }
variable "common_aws_region" { }

variable "common_vpc_id" { }
variable "common_subnet_id" { }

variable "common_username" { }
variable "common_key_name" { }
variable "common_key_path" { }

# configured by specs/machine/machineN.env.sh
variable "machine_instance_name" { }
variable "machine_instance_type" { }
variable "machine_root_volume_size" { }
variable "machine_root_volume_type" { }
variable "machine_root_delete_on_termination" { }
variable "machine_ebs_device_name" { }
variable "machine_ebs_volume_size" { }
variable "machine_ebs_type" { }
variable "machine_ebs_iops" { }
variable "machine_ebs_delete_on_termination" { }
