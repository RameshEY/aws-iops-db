resource "aws_security_group" "database" {

  depends_on = [ "data.aws_subnet.selected" ]

  name        = "${var.machine_security_group_name}"
  description = "${var.machine_security_group_name}"
  vpc_id      = "${var.common_vpc_id}"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # outbound all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
