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

# data "aws_ami" "name" {
#   most_recent = true
#   owners = ["amazon"]
# }

#Subnet id
data "aws_subnet" "name" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    name="private_subnet"
  }
}

resource "aws_instance" "MyServer" {
  ami = "ami-076c6dbba59aa92e6"
  instance_type = "t3.nano"
  subnet_id = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]
   tags = { 
    Name = "Sample_terraform_server"
  }
}

#Security Group
data "aws_security_group" "name" {
  tags={
    Name ="MyServer"
  }
}


#vpc ID
data "aws_vpc" "name" {
  tags={
    name ="my_vpc"
  }
}

#Avialability Zones
data "aws_availability_zones" "names" {
  state = "available"
}

#To get The account Details
data "aws_caller_identity" "name" {
  
}

#To get The Region Details
data "aws_region" "name" {
  
}