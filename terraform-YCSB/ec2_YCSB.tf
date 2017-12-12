# The various ${var.ycsb_foo} come from variables.tf
# Specify the provider and access details
provider "aws" {
    region = "${var.ycsb_aws_region}"
    access_key = "${var.ycsb_aws_access_key}"
    secret_key = "${var.ycsb_aws_secret_key}"
}

resource "aws_instance" "web" {

  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.ycsb_username}"

    # The path to your keyfile
    private_key = "${file("${var.ycsb_key_path}")}" 
  }

  # subnet ID for our VPC
  subnet_id = "${var.ycsb_subnet_id}"
  # the instance type we want, comes from rundeck
  instance_type = "${var.ycsb_instance_type}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.ycsb_aws_amis, var.ycsb_aws_region)}"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.ycsb_key_name}"

  # We set the name as a tag
  tags {
    "Name" = "${var.ycsb_instance_name}"
  }

  # need sg.tf later.
  security_groups = [ "${var.ycsb_security_group_name}" ]

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
    destination = "/home/ubuntu/setup_YCSB.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.ycsb_key_path}")}" 
    }
  }
 
  provisioner "file" {
    source = "./install_YCSB.sh"
    destination = "/home/ubuntu/ycsb-0.12.0/install_YCSB.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.ycsb_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /home/ubuntu/ycsb-0.12.0/install_YCSB.sh",
      "/home/ubuntu/ycsb-0.12.0/install_YCSB.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ubuntu/setup_YCSB.sh /etc/profile.d/setup_YCSB.sh"
    ]
  }

}
