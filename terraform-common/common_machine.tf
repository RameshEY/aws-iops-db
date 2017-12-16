resource "aws_instance" "machine" {

  ami                         = "${lookup(var.common_aws_amis, var.common_aws_region)}"
  key_name                    = "${var.common_key_name}"
  subnet_id                   = "${var.common_subnet_id}"

  instance_type               = "${var.machine_instance_type}"
  associate_public_ip_address = true

# fixme
# security_groups             = ["${aws_security_group.database.id}"]

  root_block_device {
    volume_size           = "${var.machine_root_volume_size}"
    volume_type           = "${var.machine_root_volume_type}"
    delete_on_termination = "${var.machine_root_delete_on_termination}"
  }

  ebs_block_device {
    device_name           = "${var.machine_ebs_device_name}"
    volume_size           = "${var.machine_ebs_volume_size}"
    volume_type           = "${var.machine_ebs_type}"
    iops                  = "${var.machine_ebs_iops}"
    delete_on_termination = "${var.machine_ebs_delete_on_termination}"
  }

  tags {
    Name = "${var.machine_instance_name}"
  }

  connection {
    user     = "${var.common_username}"
    key_file = "${var.common_key_path}"
  }

}
