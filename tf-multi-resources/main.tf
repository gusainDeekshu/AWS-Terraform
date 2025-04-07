terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}
locals {
  project="project_01"
}


provider "aws" {
  region = var.region
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_${local.project}"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name="subnet_${local.project}_${count.index}"
  }
}
#creating 4 ec2 instance
resource "aws_instance" "name" {
  # count=length(var.ec2_instance_config)
  for_each = var.ec2_map
  #we will get each key and each value
  # ami           = var.ec2_instance_config[count.index].ami
  # instance_type = var.ec2_instance_config[count.index].instance_type

  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id = element(aws_subnet.main[*].id,index(keys(var.ec2_map),each.key)% length(aws_subnet.main)) 
  # subnet_id = element(aws_subnet.main[*].id,count.index% length(aws_subnet.main)) 
  #0%2 = 0, 1%2 = 1, 2%2 = 0, 3%2 = 1
  #0,1,2,3 = 0,1,0,1
  tags = {
    # Name="${local.project}_instance_${count.index}"
    Name="${local.project}_instance_${each.key}"

  }
}

output "aws_subnet_id" {
  description = "Subnet ID"
  value = aws_subnet.main[1].id
}

