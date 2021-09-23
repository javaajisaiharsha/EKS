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

######## creating a instance in above vpc ######################
module "my_instance" {
  source = "./instance"
  ami_instance = var.ami_instance 
  instance_type = var.instance_type
  public_subnet_id = "${module.vpc.subnet2_id}"
  security_group_id  = "${module.vpc.securitygroup_id}"
}


############ create one more instance in above vpc in different subnet ###################
module "my_instance2" {
  source = "./instance"
  ami_instance = var.ami_instance
  instance_type = var.instance_type
  public_subnet_id = "${module.vpc.subnet_id}" 
  security_group_id  = "${module.vpc.securitygroup_id}"
}




