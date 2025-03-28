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

resource "aws_s3_bucket" "web-bucket" {
  bucket = "my-web-bucket${random_id.random_id.hex}"
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.web-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "web-policy" {
  bucket = aws_s3_bucket.web-bucket.id
  policy = jsonencode(
    {
    Version= "2012-10-17",
    Statement= [
        {
            Sid= "PublicReadGetObject",
            Effect= "Allow",
            Principal= "*",
            Action=  "s3:GetObject",           
            Resource=  "arn:aws:s3:::${aws_s3_bucket.web-bucket.id}/*",
        
        }
    ]
}
)
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.web-bucket.id

  index_document {
    suffix = "index.html"
  }

  
}

resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.web-bucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style_css" {
    bucket = aws_s3_bucket.web-bucket.bucket
  source = "./style.css"
  key = "style.css"
  content_type = "text/css"

}

output "name" {
  value = aws_s3_bucket_website_configuration.website_config.website_endpoint
}