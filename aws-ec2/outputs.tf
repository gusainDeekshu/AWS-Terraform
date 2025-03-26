output "aws_instance_output" {
  value = aws_instance.myTerraformServer.public_ip
}