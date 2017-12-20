output "instance_id" {
  value = "${aws_instance.database.id}"
}

output "private_ip" {
  value = "${aws_instance.database.private_ip}"
}

output "public_dns" {
  value = "${aws_instance.database.public_ip}"
}
