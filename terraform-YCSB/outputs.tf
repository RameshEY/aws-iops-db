output "ec2_YCSB" {
  value = "${aws_instance.ycsb.public_ip}"
}
