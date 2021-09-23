provider "aws" {
   region= "ap-south-1"
}

module "vpc" {
  source = "./vpc"
#  public_subnet_cidr_block = "var.public_subnet_cidr_block"
  cidr_block               = var.cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  public1_subnet_cidr_block = var.public1_subnet_cidr_block
  av_zone1                  = var.av_zone1
  av_zone2                  = var.av_zone2
}
