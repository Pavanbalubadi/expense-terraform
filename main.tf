module "vpc" {
  source          = "./module/vpc"
  vpc_cidr_block  = var.vpc_cidr_block
  env             = var.env
  tags            = var.tags
  public_subnets  = var.public_subnets
  web_subnets     = var.web_subnets
  app_subnets     = var.app_subnets
  db_subnets      = var.db_subnets
  azs             = var.azs
  account_id = var.account_id
  default_vpc_id = var.default_vpc_id
  default_route_table_id = var.default_route_table_id
}