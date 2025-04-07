variable "region" {
  description = "This is variable for region"
  type        = string
  default     = "ap-south-1"
}

variable "ec2_instance_config" {
  type = list(object({
    ami           = string
    instance_type = string
  }))

}

variable "ec2_map" {
  type = map(object({
    ami           = string
    instance_type = string
  }))

}

