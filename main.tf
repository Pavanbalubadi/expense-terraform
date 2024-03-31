module "vpc" {
  source = "./modules/vpc"
  env    = var.env
  tags   = var.tags
  vpc_cidr_block = var.vpc_cidr_block
  app_subnets = var.public_subnets
  azs = var.azs
  db_subnets = var.db_subnets
  public_subnets = var.public_subnets
  web_subnets = var.web_subnets
}
