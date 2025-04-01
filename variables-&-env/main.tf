terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

locals {
  volume_type="gp2"
}


resource "aws_instance" "myTerraformServer" {
  ami           = "ami-05c179eced2eb9b5b"
  instance_type = var.aws_instance_type
  root_block_device {
    delete_on_termination = true
    # volume_size           = var.root_volume_size
    # volume_type           = var.root_volume_type
     volume_size           = var.ec2_root_block_config.volume_size
    volume_type           = local.volume_type
  }
  tags = merge(var.additional_tags,{
    name = "SampleServer"
  })
}
