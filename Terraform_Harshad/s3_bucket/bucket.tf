provider aws {
  region = "ap-south-1"
}


resource "aws_s3_bucket" "bucket" {
  bucket = "harshad"
  acl    = "private"

  tags = {
    Name        = "dev-config"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true  
  ignore_public_acls  = true
}
