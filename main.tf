module "vpc" {
  source          = "./Module/vpc"
  vpc_cidr_block  = var.vpc_cidr_block
}