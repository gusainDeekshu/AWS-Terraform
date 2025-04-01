variable "aws_instance_type" {
  description = "what type of instance you want to create"
  type        = string
  validation {
    condition     = var.aws_instance_type == "t3.nano" || var.aws_instance_type == "t3.micro"
    error_message = "Instance type t3.nano and t3.micro allowed"
  }
}

variable "root_volume_size" {
  description = "what type of volume size you wnat to give"
  type        = number
  default     = 20
}


# variable "root_volume_type" {
#   description = "what type of volume size you wnat to give"
#   type = string
#   default = "gp2"
# }

variable "ec2_root_block_config" {
  type = object({
    volume_size = number
    volume_type = string
  })

  default = {
    volume_size = 40
    volume_type = "gp3"
  }
}


variable "additional_tags" {
  type = map(string) # expecting key=value format
  default = {
    "name" = "value"
  }
}