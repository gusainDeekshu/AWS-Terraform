provider "aws" {
  region = "ap-south-1"
  
}
data "aws_availability_zones" "name" {
  state = "available"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.name.names
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}