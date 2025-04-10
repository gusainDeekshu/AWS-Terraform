provider "aws" {
  region = "ap-south-1"

}

module "test-vpc" {
  source  = "gusainDeekshu/test-vpc/aws"
  version = "1.0.0"
  # insert the 2 required variables here

    vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "test_module_vpc"
  }
  subnet_config = {
    public_subnet = {
      cidr_block = "10.0.0.0/24"
      az         = "ap-south-1a"
      #To set the subnet as public, default is private
      public     = true
    }

    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-south-1b"
    }
  }
}