export TF_VAR_machine_instance_name="iopstest (machine3) (r3.4xlarge)"
export TF_VAR_machine_instance_type="r3.4xlarge"
export TF_VAR_machine_security_group_name=$TF_VAR_machine_instance_name

export TF_VAR_machine_root_volume_size=50
export TF_VAR_machine_root_volume_type="gp2"
export TF_VAR_machine_root_delete_on_termination="true"

export TF_VAR_machine_ebs_device_name="/dev/xvdh"
export TF_VAR_machine_ebs_volume_size="320"
export TF_VAR_machine_ebs_type="gp2"
export TF_VAR_machine_ebs_iops="960"
export TF_VAR_machine_ebs_delete_on_termination="true"
