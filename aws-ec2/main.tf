
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

resource "aws_instance" "myTerraformServer" {
  ami           = "ami-05c179eced2eb9b5b"
  instance_type = "t3.micro"

  tags = { 
    Name = "Sample_terraform_server"
  }
}
