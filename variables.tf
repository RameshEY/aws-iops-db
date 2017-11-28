variable "key_name" {
    description = "The PEM key name."
    default = "kenzan-scratch"
}

variable "key_path" {
    description = "The key path"
    default = ""
}

variable "aws_region" {
    description = "The region"
    default = "us-east-1"
}

variable "aws_access_key" {
    #decscription = "The AWS access key name."
    default = ""
}

variable "aws_secret_key" {
    description = "The AWS secret key."
    default = ""
}

variable "subnet_id" {
    description = "The subnet"
    default = "subnet-83d34bdb"
}

variable "instance_type" {
    description = "The instance type."
    default = "r4.4xlarge"
}

variable "instance_name" {
    description = "The instance name."
    default = ""
}

variable "security_group_name" {
    description = "The security group name."
    default = "testing123"
}

variable "vpc_id" {
    description = "The VPC ID for Security Group"
    default = "vpc-ae6425ca"
}

#variable "aws_amis" {
#    default = {
#       us-east-1: "ami-de7ab6b6"
#    }
#}