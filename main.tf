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
  account_id = var.account_id
  default_route_table_id = var.default_route_table_id
}

module"rds" {

  source   = "./modules/rds"
  env      = var.env
  subnets  = var.subnets
  tags     = var.tags
  sg_cidrs = ""
  vpc_id   = module.vpc.vpc_id
}