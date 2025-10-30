provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../../aws/modules/vpc"
  environment = var.environment
  cidr = var.cidr
  enable_nat_gateway = var.enable_nat_gateway
  availability_zones = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ec2" {
  source = "../../../aws/modules/ec2"
  instance_count = var.instance_count
  instance_type = var.instance_type
  user_data_script = var.user_data_script
}

module "rds" {
  source = "../../../aws/modules/rds"
  instance_class = var.instance_class
  password = var.password
}

module "s3" {
  source = "../../../aws/modules/s3"
  bucket_name = var.bucket_name
}