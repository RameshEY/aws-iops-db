output "ec2_YCSB" {
  value = "${aws_instance.web.public_ip}"
}
