resource "null_resource" "mongodb" {

  depends_on = [ "aws_instance.database" ]

  /**
   * setup provisioning folder
   */

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ${var.mgdb_user_name}:${var.mgdb_user_name} /tmp/provisioning/"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.mgdb_user_name}"
      private_key = "${file("${var.mgdb_key_path}")}"
    }
  }

  /**
   * system config
   */

  provisioner "file" {
    source = "${template_dir.database_config.destination_dir}/mgdb_system.sh"
    destination = "/tmp/provisioning/mgdb_system.sh"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.mgdb_user_name}"
      private_key = "${file("${var.mgdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod ugo+x /tmp/provisioning/mgdb_system.sh",
      "sudo /tmp/provisioning/mgdb_system.sh"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.mgdb_user_name}"
      private_key = "${file("${var.mgdb_key_path}")}"
    }
  }

  /**
   * install the software
   */

  provisioner "file" {
    source = "${template_dir.database_config.destination_dir}/mgdb_install.sh"
    destination = "/tmp/provisioning/mgdb_install.sh"
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.mgdb_user_name}"
      private_key = "${file("${var.mgdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod ugo+x /tmp/provisioning/mgdb_install.sh",
      "sudo /tmp/provisioning/mgdb_install.sh",
      "echo done"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.mgdb_user_name}"
      private_key = "${file("${var.mgdb_key_path}")}"
    }
  }

}
