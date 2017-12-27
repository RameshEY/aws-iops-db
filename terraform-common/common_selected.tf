data "aws_vpc" "selected" {
  id = "${var.common_vpc_id}"
}

data "aws_subnet" "selected" {
  id = "${var.common_subnet_id}"
}
