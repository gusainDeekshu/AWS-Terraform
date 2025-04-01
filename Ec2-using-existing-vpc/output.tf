# output "aws_ami" {
# value =data.aws_ami.name.id  
# }

output "aws_vpc" {
value =data.aws_vpc.name.id
}

output "security_group" {
value= data.aws_security_group.name.id  
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.names
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.name
}

output "region" {
  value = data.aws_region.name
}