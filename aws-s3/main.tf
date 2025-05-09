terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

provider "aws" {
     # Configuration options
  region = var.region
  
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

output "name" {
  value = random_id.random_id.b64_url
}