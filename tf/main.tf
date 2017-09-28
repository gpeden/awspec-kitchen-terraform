provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"

  tags {
    Name = "my-vpc"
  }
}

resource "aws_security_group" "sg" {
  name = "my-security-group"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags {
    Name = "my-security-group"
  }
}

resource "aws_instance" "server" {
  ami = "${var.ami}"
  instance_type = "t2.micro"

  tags {
    Name = "my-server"
  }
}
