export TF_VAR_machine_name="i3.4xlarge NVMe"
export TF_VAR_machine_instance_type="i3.4xlarge"
export TF_VAR_machine_root_volume_size=50
export TF_VAR_machine_root_volume_type="gp2"
export TF_VAR_machine_root_delete_on_termination="true"

export TF_VAR_machine_ebs_device_name="/dev/xvdh"
export TF_VAR_machine_ebs_volume_size="3800"
export TF_VAR_machine_ebs_type="gp2"
export TF_VAR_machine_ebs_iops="1000" 
export TF_VAR_machine_ebs_delete_on_termination="true"
