# The various ${var.foo} come from variables.tf

# Specify the provider and access details
provider "aws" {
    region = "${var.aws_region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
}


resource "aws_instance" "web" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ubuntu"

    # The path to your keyfile
    private_key = "${var.key_path}"
  }

  # subnet ID for our VPC
  subnet_id = "${var.subnet_id}"
  # the instance type we want, comes from rundeck
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.iops.id}"]

  # Lookup the correct AMI based on the region
  # we specified
  #ami = "${lookup(var.aws_amis, var.aws_region)}"
  ami = "ami-da05a4a0"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.key_name}"


  # We set the name as a tag
  tags {
    "Name" = "${var.instance_name}"
  }

  provisioner "remote-exec" {
        inline = [
          "wget https://github.com/brianfrankcooper/YCSB/releases/download/0.12.0/ycsb-0.12.0.tar.gz -O- | tar -xz",
          "cd ycsb-0.12.0/",
          "ls -l",
          "git clone https://github.com/kenzanlabs/cassandra-ycsb-tests.git"
        ]
      }
}