######################## inputs to vpc ###################################
variable "aws_region_name"  { default = "ap-south-1" }
variable "cidr_block"    { default = "11.0.0.0/16" }
variable "public_subnet_cidr_block"  { default = "11.0.0.0/24" }
variable "public1_subnet_cidr_block"  { default = "11.0.2.0/24"}
variable "av_zone1" { default = "ap-south-1a" }
variable "av_zone2" { default = "ap-south-1b" }


##### instance settings #######################################
variable "ami_instance" { default = "ami-011c99152163a87ae" }
variable "instance_type" { default = "t2.micro" }
variable "public_subnet_id" { default = "subnet-044ef28635cf33c96" }


