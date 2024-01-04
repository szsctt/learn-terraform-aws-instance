terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

}

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "${var.cidr_vpc}"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "test_subnet_public" {
  vpc_id     = "${aws_vpc.test_vpc.id}" 
  cidr_block = "${var.cidr_subnet}"
  availability_zone = "${var.availability_zone}"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = "${aws_vpc.test_vpc.id}"
}

resource "aws_route_table" "test_route_table" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test_igw.id}"
    }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = "${aws_subnet.test_subnet_public.id}"
  route_table_id = "${aws_route_table.test_route_table.id}"
}

resource "aws_security_group" "sg_22" {
    name = "sg_22"
    vpc_id = "${aws_vpc.test_vpc.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "test_key" {
  key_name   = "test_key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.test_key.key_name
  subnet_id     = aws_subnet.test_subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  
  depends_on = [aws_internet_gateway.test_igw]

  tags = {
    Name = var.instance_name
  }

}

