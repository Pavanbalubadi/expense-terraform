module "vpc" {
  source          = "module/vpc"
  vpc_cidr_block  = var.vpc_cidr_block
}