provider "aws" {
  region = var.aws_region
}

module "networking" {
  source               = "../../services/networking"
  client_name          = var.client_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnets
  private_subnet_cidrs = var.private_subnets
  azs                  = var.azs
}

module "compute" {
  source            = "../../services/compute"
  client_name       = var.client_name
  environment       = var.environment
  vpc_id            = module.networking.vpc_id
  public_subnet_id  = module.networking.public_subnet_ids[0]
  private_subnet_id = module.networking.private_subnet_ids[0]
  instance_type     = var.instance_type
  ami_id            = var.ami_id
  public_key        = var.public_key
}