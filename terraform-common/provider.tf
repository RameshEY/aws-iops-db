# Specify the provider and access details
provider "aws" {
    region = "${var.common_aws_region}"
    access_key = "${var.common_aws_access_key}"
    secret_key = "${var.common_aws_secret_key}"
}

