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

/* for future use
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
*/
