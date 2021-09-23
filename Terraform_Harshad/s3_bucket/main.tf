provider aws {
  region = "ap-south-1"
}

####################### creating a s3 bucket ###################################
#resource "aws_s3_bucket" "b" {
#  bucket = "my-tf-test-bucket"
#  acl    = "private"
#  tags = {
#    Name        = "My bucket"
#    Environment = "Dev"
#  }
#}

################################# list of buckets fetching with terraform datasources #############################


data "aws_s3_bucket" "selected" {
  bucket = "maven-repo-test2"
}
