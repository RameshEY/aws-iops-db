data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user-data.sh")}"

  vars {
    mongodb_version      = "${var.mongodb_version}"
    mongodb_basedir      = "${var.mongodb_basedir}"
    mongodb_conf_logpath = "${var.mongodb_conf_logpath}"
    mongodb_conf_engine  = "${var.mongodb_conf_engine}"

    aws_region       = "${var.aws_region}"
    config_ephemeral = "${var.config_ephemeral}"
    config_ebs       = "${var.config_ebs}"
  }
}

resource "aws_instance" "mongodb" {
  ami                         = "${var.ec2_ami_id}"
  instance_type               = "${var.ec2_instance_type}"
  key_name                    = "mongodb"
  user_data                   = "${data.template_file.user_data.rendered}"
  security_groups             = ["${aws_security_group.mongo.id}"]
  subnet_id                   = "${var.subnet_id}"
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 64
    volume_type           = "gp2"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdz"
    volume_type = "gp2"
    volume_size = 100
  }

  tags {
    Name = "${var.name}"
  }

  connection {
    user     = "ubuntu"
    key_file = "${var.key_file}"
  }
}

output "instance_id" {
  value = "${aws_instance.mongodb.id}"
}

output "private_ip" {
  value = "${aws_instance.mongodb.private_ip}"
}

output "public_dns" {
  value = "${aws_instance.mongodb.public_dns}"
}
