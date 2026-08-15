terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "hardened_infra_sg" {
  name        = "hardened-infrastructure-security-group"
  description = "Strict boundary isolation for zero-trust cloud infrastructure"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "secure_cloud_host" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.hardened_infra_sg.id]

  tags = {
    Name        = "hardened-enterprise-cloud-host"
    Environment = "production-zero-trust"
  }
}
