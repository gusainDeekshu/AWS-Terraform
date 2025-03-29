resource "aws_instance" "nginixserver" {
  ami           = "ami-05c179eced2eb9b5b"
  instance_type = "t3.nano"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true
  user_data     = <<-EOF
                 #!/bin/bash
                 sudo yum install nginx -y
                 sudo systemctl enable nginx
                 sudo systemctl start nginx
                 EOF
  tags = {
    Name = "NginxWebserver"
  }
}
