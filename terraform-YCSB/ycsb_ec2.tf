resource "aws_instance" "ycsb" {

  ami = "${lookup(var.ycsb_aws_amis, var.ycsb_aws_region)}"
  instance_type = "${var.ycsb_instance_type}"
  key_name = "${var.ycsb_key_name}"
  subnet_id = "${var.ycsb_subnet_id}"

  security_groups = [ "${aws_security_group.ycsb.id}"]

  connection {
    user = "${var.ycsb_username}"
    private_key = "${file("${var.ycsb_key_path}")}" 
  }

  tags {
    "Name" = "${var.ycsb_instance_name}"
  }

  provisioner "remote-exec" {
    inline = [
      "wget https://github.com/brianfrankcooper/YCSB/releases/download/0.12.0/ycsb-0.12.0.tar.gz -O- | tar -xz",
      "cd ycsb-0.12.0/",
      "ls -l",
      "git clone https://github.com/kenzanlabs/cassandra-ycsb-tests.git"
    ]
  }

  provisioner "file" {
    source = "./setup_YCSB.sh"
    destination = "/home/${var.ycsb_username}/setup_YCSB.sh"
    connection {
      type = "ssh"
      user = "${var.ycsb_username}"
      private_key = "${file("${var.ycsb_key_path}")}" 
    }
  }
 
  provisioner "file" {
    source = "./install_YCSB.sh"
    destination = "/home/${var.ycsb_username}/ycsb-0.12.0/install_YCSB.sh"
    connection {
      type = "ssh"
      user = "${var.ycsb_username}"
      private_key = "${file("${var.ycsb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /home/${var.ycsb_username}/ycsb-0.12.0/install_YCSB.sh",
      "/home/${var.ycsb_username}/ycsb-0.12.0/install_YCSB.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/${var.ycsb_username}/setup_YCSB.sh /etc/profile.d/setup_YCSB.sh"
    ]
  }

  #
  # provision ycsb workloads
  #

  provisioner "file" {
    source = "ReadIntensiveLoad"
    destination = "/home/${var.ycsb_username}/ycsb-0.12.0/workloads/ReadIntensiveLoad"
    connection {
      type = "ssh"
      user = "${var.ycsb_username}"
      private_key = "${file("${var.ycsb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "ReadWriteMixedLoad"
    destination = "/home/${var.ycsb_username}/ycsb-0.12.0/workloads/ReadWriteMixedLoad"
    connection {
      type = "ssh"
      user = "${var.ycsb_username}"
      private_key = "${file("${var.ycsb_key_path}")}"
    }
  }

  provisioner "file" {
    source = "WriteIntensiveLoad"
    destination = "/home/${var.ycsb_username}/ycsb-0.12.0/workloads/WriteIntensiveLoad"
    connection {
      type = "ssh"
      user = "${var.ycsb_username}"
      private_key = "${file("${var.ycsb_key_path}")}"
    }
  }

  #
  # provision and run ycsb_run_test.sh (provided by database)
  #

  provisioner "file" {
    source = "./ycsb_run_test.sh"
    destination = "/home/${var.ycsb_username}/ycsb_run_test.sh"
    connection {
      type = "ssh"
      user = "${var.ycsb_username}"
      private_key = "${file("${var.ycsb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /home/${var.ycsb_username}/ycsb_run_test.sh",
      "(/home/${var.ycsb_username}/ycsb_run_test.sh ${aws_instance.database.private_ip} ${var.ycsb_desired_workload}) 2>&1 | tee /home/${var.ycsb_username}/ycsb_run_test.log"
    ]
  }


}
