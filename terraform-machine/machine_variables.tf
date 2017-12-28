variable machine_instance_type { }
variable machine_instance_name { }
variable machine_security_group_name { }

variable "machine_root_volume_size" { }
variable "machine_root_volume_type" { }
variable "machine_root_delete_on_termination" { }

# configured by specs/machine/machineN.env.sh
variable "machine_ebs_device_name" { }
variable "machine_ebs_volume_size" { }
variable "machine_ebs_type" { }
variable "machine_ebs_iops" { }
variable "machine_ebs_delete_on_termination" { }
