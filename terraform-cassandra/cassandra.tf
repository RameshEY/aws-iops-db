resource "null_resource" "cassandra" {

  depends_on = [ "aws_instance.database" ]

  /**
   * installation and provisioning database
   */

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ${var.csdb_user_name}:${var.csdb_user_name} /tmp/provisioning/"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  /**
   * setup system (filesystem, etc)
   */

  provisioner "file" {
    source = "csdb_system.sh"
    destination = "/tmp/provisioning/csdb_system.sh"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod ugo+x /tmp/provisioning/csdb_system.sh",
      "sudo /tmp/provisioning/csdb_system.sh",
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "init_cassandra.cql"
    destination = "/tmp/provisioning/init_cassandra.cql"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "install_cassandra.sh"
    destination = "/tmp/provisioning/install_cassandra.sh"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "${template_dir.database_config.destination_dir}/etc/cassandra/cassandra.yaml"
    destination = "/tmp/provisioning/cassandra.yaml"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "cassandra-env.sh"
    destination = "/tmp/provisioning/cassandra-env.sh"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod ugo+x /tmp/provisioning/install_cassandra.sh",
      "sudo chmod ugo+x /tmp/provisioning/setup_cassandra.sh",
      "sudo /tmp/provisioning/install_cassandra.sh",
      "sudo /tmp/provisioning/setup_cassandra.sh"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

}
