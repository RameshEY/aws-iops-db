resource "aws_security_group" "ycsb" {

  depends_on = [ "data.aws_subnet.selected" ]

  name = "${var.ycsb_security_group_name}"
  description = "Allows all traffic"
  vpc_id      = "${var.ycsb_vpc_id}"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
