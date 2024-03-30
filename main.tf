module "vpc" {
  source = "./modules/vpc"
  env    = var.env
  tags   = var.tags
  vpc_cidr_block = var.vpc_cidr_block
}
