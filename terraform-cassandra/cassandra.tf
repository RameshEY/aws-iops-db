resource "null_resource" "cassandra" {

  depends_on = [ "aws_instance.database" ]

  /**
   * setup data mount
   */
  
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/lib/cassandra",
      "sudo mount /dev/xvdh /var/lib/cassandra",
      "echo '/dev/xvdh /var/lib/cassandra ext4 defaults 0 0' | sudo tee -a /etc/fstab"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  /**
   * setup provisioning folder
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

  provisioner "remote-exec" {
    inline = [
      "sudo chmod ugo+x /tmp/provisioning/setup_cassandra.sh",
      "sudo /tmp/provisioning/setup_cassandra.sh 0"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  /**
   * config for test
   */

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

  /**
   * service start
   */

  provisioner "remote-exec" {
    inline = [
      "sudo cp -f /tmp/provisioning/cassandra.yaml /etc/cassandra/cassandra.yaml",
      "sudo rm -Rf /var/lib/cassandra/*"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo service cassandra force-reload",
      "ps -ef | grep cass",
      "nodetool status"
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }


  /**
   * initialize
   */

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

  provisioner "remote-exec" {
    inline = [
      "sleep 2",
      "nodetool status",
      "cat /tmp/provisioning/init_cassandra.cql | cqlsh --cqlversion=3.4.0 ${aws_instance.database.private_ip}",
    ]
    connection {
      type = "ssh"
      host = "${aws_instance.database.public_ip}"
      user = "${var.csdb_user_name}"
      private_key = "${file("${var.csdb_key_path}")}"
    }
  }


}
