output "instance_public_ip" {
description = "This Is Public ip for ec2"
value = aws_instance.nginixserver.public_ip
}

output "instance_url" {
  description = "This Is Public Url for ec2"
value = "http://${aws_instance.nginixserver.public_ip}"
}