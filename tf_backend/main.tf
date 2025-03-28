terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
  backend "s3" {
    bucket = "bucket4c3a46745d2cbc01"
    key = "backen-tfstate"
    region = "ap-south-1"
  }
}

resource "random_id" "random_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "bucket${random_id.random_id.hex}"
}

resource "aws_s3_object" "bucket_data" {
    bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./myfile.txt"
  key = "mydata.txt"
}
