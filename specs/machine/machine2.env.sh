export TF_VAR_machine_name="r4.4xlarge 10K io1"
export TF_VAR_machine_instance_type="r4.4xlarge"
export TF_VAR_machine_root_volume_size=50
export TF_VAR_machine_root_volume_type="gp2"
export TF_VAR_machine_root_delete_on_termination="true"

export TF_VAR_machine_ebs_device_name="/dev/xvdh"
export TF_VAR_machine_ebs_volume_size="1000"
export TF_VAR_machine_ebs_type="io1"
export TF_VAR_machine_ebs_iops="10000"
export TF_VAR_machine_ebs_delete_on_termination="true"

