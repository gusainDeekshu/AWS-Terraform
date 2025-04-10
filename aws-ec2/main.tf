
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
resource "aws_security_group" "my-sg" {
  name = "my-sg"
  ingress {
    from_port  = 8080
    to_port    = 8080
    protocol   = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
resource "aws_instance" "myTerraformServer" {
  ami             = "ami-05c179eced2eb9b5b"
  instance_type   = "t3.micro"
  vpc_security_group_ids =  [aws_security_group.my-sg.id]
  depends_on = [ aws_security_group.my-sg ]
  tags = {
    Name = "Sample_terraform_server"
  }
  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    # ignore_changes = [  ]
    replace_triggered_by = [ aws_security_group.my-sg ,aws_security_group.my-sg.ingress]
  }
}
