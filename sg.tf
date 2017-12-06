resource "aws_security_group" "iops" {
  name = "${var.security_group_name}"
  description = "Allows all traffic"
  vpc_id      = "${var.vpc_id}"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # HTTP
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "107.0.143.2/32"
    ]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "65.202.51.130/32"
    ]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "98.191.15.66/32"
    ]
  }

  # HTTPS
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "107.0.143.2/32"
    ]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "65.202.51.130/32"
    ]
  }


  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "98.191.15.66/32"
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
