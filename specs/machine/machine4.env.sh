export TF_VAR_machine_instance_name="iopstest (machine4) (i3.4xlarge NVMe)"
export TF_VAR_machine_instance_type="i3.4xlarge"
export TF_VAR_machine_security_group_name=$TF_VAR_machine_instance_name

export TF_VAR_machine_root_volume_size=50
export TF_VAR_machine_root_volume_type="gp2"
export TF_VAR_machine_root_delete_on_termination="true"

export TF_VAR_machine_ephemeral_delete_on_termination="true"
