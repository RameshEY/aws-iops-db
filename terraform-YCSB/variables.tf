variable "username" {
    description = "The default user on the ec2 instance."
    default = "ubuntu"
}

variable "key_name" {
    description = "The PEM key name."
}

variable "key_path" {
    description = "The key path"
}

variable "aws_region" {
    description = "The region"
}

variable "aws_access_key" {
    description = "The AWS access key name."
}

variable "aws_secret_key" {
    description = "The AWS secret key."
}

variable "subnet_id" {
    description = "The subnet"
    default = "subnet-83d34bdb"
}

variable "instance_type" {
    description = "The instance type."
    default = "t2.micro"
}

variable "instance_name" {
    description = "The instance name."
    default = "kliu-YCSB"
}

variable "aws_amis" {
    description = "Which AMI to spawn."
    default = {
       us-east-1 = "ami-cd0f5cb6"
    }
}

variable "security_group_name" {
    description = "The sg name."
    default = "sg-42044237"
}

variable "vpc_id" {
    description = "The vpc name."
    default = "vpc-ae6425ca"
}
