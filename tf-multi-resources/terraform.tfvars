ec2_instance_config = [{
  ami           = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  }, {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
}]

ec2_map = {
    #key=value
    "ubuntu" = {
       ami           = "ami-0e35ddab05955cf57"
  instance_type = "t3.micro"
    },"linux"={
        ami           = "ami-002f6e91abff6eb96"
  instance_type = "t3.micro"
}
    }