resource "aws_security_group" "database" {
  name        = "${var.csdb_security_group_name}"
  description = "${var.csdb_security_group_name}"
  vpc_id      = "${var.csdb_vpc_id}"

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

// Allow any internal network flow.
resource "aws_security_group_rule" "database_ingress_any_any_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  self              = true
  type              = "ingress"
}

// Allow TCP:9042 (Cassandra clients).
resource "aws_security_group_rule" "database_ingress_tcp_9042_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 9042
  to_port           = 9042
  protocol          = "tcp"
  cidr_blocks       = "${var.csdb_source_cidr_block}"
  type              = "ingress"
}

// Allow TCP:9160 (Cassandra Thrift clients)
resource "aws_security_group_rule" "database_ingress_tcp_9160_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 9160
  to_port           = 9160
  protocol          = "tcp"
  cidr_blocks       = "${var.csdb_source_cidr_block}"
  type              = "ingress"
}

// Allow TCP:7199 (JMX)
resource "aws_security_group_rule" "database_ingress_tcp_7199_self" {
  security_group_id = "${aws_security_group.database.id}"
  from_port         = 7199
  to_port           = 7199
  protocol          = "tcp"
  cidr_blocks       = "${var.csdb_source_cidr_block}"
  type              = "ingress"
}
