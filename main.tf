# # printing output of resource value after resource creation 
# # using output module 
# from line 30 to 42 way to access default VPC

provider "aws" {
}

variable "env" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "avail_zone" {}


resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}_vpc"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.subnet_cidr          # "192.168.20.0/24"
  availability_zone = var.avail_zone        # "ap-south-1a"
  tags = {
    Name = "${var.env}_subnet"
  }
}

# create aws internet gateway

resource "aws_internet_gateway" "my_vpc_gateway" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    "Name" = "${var.env}_gateway"
  }
}

# create aws route table for dev_vpc

resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.dev-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_vpc_gateway.id
  } 
  tags = {
    "Name" = "${var.env}_rtb"
  }
}

# connect route table with subnet 

resource "aws_route_table_association" "associate_route_table" {
  subnet_id = aws.subnet.dev-subnet-1.id
  route_table_id = aws_route_table.vpc_route_table.id
}