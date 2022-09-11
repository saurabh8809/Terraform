# # printing output of resource value after resource creation 
# # using output module 
# from line 30 to 42 way to access default VPC

provider "aws" {
}

variable "vpc_cidr" {}
variable "vpc_name" {}
variable "subnet_cidr" {}
variable "subnet_name" {}
variable "avail_zone" {}


resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.vpc_name}_vpc"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.subnet_cidr          # "192.168.20.0/24"
  availability_zone = var.avail_zone        # "ap-south-1a"
  tags = {
    Name = "${var.subnet_name}_subnet"
  }
}

