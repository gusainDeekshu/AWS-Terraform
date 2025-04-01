aws_instance_type = "t3.micro"
ec2_root_block_config = {
  volume_size = 30
  volume_type = "gp3"
}

additional_tags = {
  Dept = "QA"
  project= "MtqaProject"
}