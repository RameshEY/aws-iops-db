resource "aws_instance" "cassandra_0" {
  instance_type = "${var.csdb_instance_type}"
  ami = "${var.csdb_ami}"
  key_name = "${var.csdb_key_name}"
  private_ip = "${var.csdb_cassandra0_ip}"
  subnet_id = "${aws_subnet.main.id}"
  vpc_security_group_ids = ["${module.cassandra_security_group.security_group_id}", "${aws_security_group.allow_internet_access.id}", "${aws_security_group.allow_all_ssh_access.id}"]
  depends_on = ["aws_internet_gateway.gw"]

  tags {
    Name = "${var.csdb_instance_name}"
  }

  root_block_device {
    volume_size = "${var.csdb_root_block_size}"
    volume_type = "${var.csdb_root_block_type}"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "${var.csdb_ebs_device_name}"
    volume_size = "${var.csdb_ebs_volume_size}"
    volume_type = "${var.csdb_ebs_type}"
    iops = "${var.csdb_ebs_iops}"
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod ugo+x /tmp/provisioning/setup_cassandra.sh",
      "sudo /tmp/provisioning/setup_cassandra.sh 0"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

}


# uncomment below sections if there are other nodes in the Cassandra cluster, e.g. 2-3 nodes
/*
resource "aws_instance" "cassandra_1" {
  instance_type = "${var.csdb_instance_type}"
  ami = "${var.csdb_ami}"
  key_name = "${var.csdb_key_name}"
  private_ip = "${var.csdb_cassandra1_ip}"
  subnet_id = "${aws_subnet.main.id}"
  vpc_security_group_ids = ["${module.cassandra_security_group.security_group_id}", "${aws_security_group.allow_internet_access.id}", "${aws_security_group.allow_all_ssh_access.id}"]
  depends_on = ["aws_internet_gateway.gw", "aws_instance.cassandra_0"]

  tags {
    Name = "${var.csdb_user_prefix}_${var.csdb_user_name}_cassandra_1"
  }

  root_block_device {
    volume_size = "${var.csdb_root_block_size}"
    volume_type = "${var.csdb_root_block_type}"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "${var.csdb_ebs_device_name}"
    volume_size = "${var.csdb_ebs_volume_size}"
    volume_type = "${var.csdb_ebs_type}"
    iops = "${var.csdb_ebs_iops}"
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod ugo+x /tmp/provisioning/setup_cassandra.sh",
      "sudo /tmp/provisioning/setup_cassandra.sh 1"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

}

resource "aws_instance" "cassandra_2" {
  instance_type = "${var.csdb_instance_type}"
  ami = "${var.csdb_ami}"
  key_name = "${var.csdb_key_name}"
  private_ip = "${var.csdb_cassandra2_ip}"
  subnet_id = "${aws_subnet.main.id}"
  vpc_security_group_ids = ["${module.cassandra_security_group.security_group_id}", "${aws_security_group.allow_internet_access.id}", "${aws_security_group.allow_all_ssh_access.id}"]
  depends_on = ["aws_internet_gateway.gw", "aws_instance.cassandra_1"]

  tags {
    Name = "${var.csdb_user_prefix}_${var.csdb_user_name}_cassandra_2"
  }

  root_block_device {
    volume_size = "${var.csdb_root_block_size}"
    volume_type = "${var.csdb_root_block_type}"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "${var.csdb_ebs_device_name}"
    volume_size = "${var.csdb_ebs_volume_size}"
    volume_type = "${var.csdb_ebs_type}"
    iops = "${var.csdb_ebs_iops}"
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod ugo+x /tmp/provisioning/setup_cassandra.sh",
      "sudo /tmp/provisioning/setup_cassandra.sh 2"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

}
*/
