resource "aws_security_group" "database" {

  depends_on = [ "data.aws_subnet.selected" ]

  name        = "${var.mgdb_security_group_name}"
  description = "${var.mgdb_security_group_name}"
  vpc_id      = "${var.common_vpc_id}"

  description = "Allow all inbound traffic"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

/* so bad!
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Allow any internal network flow.
resource "aws_security_group_rule" "database_ingress_any_any_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  self              = true
  type              = "ingress"
}

resource "aws_security_group_rule" "database_ingress_tcp_27017_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  cidr_blocks       = ["${data.aws_subnet.selected.cidr_block}"]
  type              = "ingress"
}

resource "aws_security_group_rule" "database_ingress_tcp_27018_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 27018
  to_port           = 27018
  protocol          = "tcp"
  cidr_blocks       = ["${data.aws_subnet.selected.cidr_block}"]
  type              = "ingress"
}

resource "aws_security_group_rule" "database_ingress_tcp_27019_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 27019
  to_port           = 27019
  protocol          = "tcp"
  cidr_blocks       = ["${data.aws_subnet.selected.cidr_block}"]
  type              = "ingress"
}

