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
  sg_cidrs = var.sg_cidrs
  vpc_id   = module.vpc.vpc_id
  kms_key  = var.kms_key
  rds_allocated_storage = var.rds_allocated_storage
  rds_engine = var.rds_engine
  rds_instance_class = var.rds_instance_class
  rds_engine_version = var.rds_engine_version
}

module"backend"{
  depends_on = [module.backend-alb,module.public-alb,module.rds]
  source = "./modules/app"
  app_port = var.backend["app_port"]
  bastion_cidrs = var.bastion_cidrs
  component = var.component
  env = var.env
  instance_count = var.backend["instance_count"]
  instance_type = var.backend["instance_type"]
  kms_key = var.kms_key
  sg_cidrs = var.sg_cidrs
  subnets = var.subnets
  tags = var.tags
  vpc_id = module.vpc.vpc_id
}

module"frontend"{
  depends_on = [module.backend-alb,module.public-alb]
  source = "./modules/app"
  app_port = var.frontend["app_port"]
  bastion_cidrs = var.bastion_cidrs
  component = var.component
  env = var.env
  instance_count = var.frontend["instance_count"]
  instance_type = var.frontend["instance_type"]
  kms_key = var.kms_key
  sg_cidrs = var.sg_cidrs
  subnets = var.subnets
  tags = var.tags
  vpc_id = module.vpc.vpc_id
}

module"public-alb"{
  source = "./modules/alb"
  certificate_arn = var.certificate_arn
  component = var.public-alb["component"]
  enable_https = var.public-alb["enable_https"]
  env = var.env
  internal = var.public-alb["internal"]
  lb_port = var.public-alb["lb_port"]
  route53_zone_id = var.route53_zone_id
  sg_cidrs = ["0.0.0.0/0"]
  subnets = var.public_subnets
  tags = var.tags
  target_group_arn = module.frontend.target_group_arn
  vpc_id = module.vpc.vpc_id
}
module "backend-alb" {
  source = "./modules/app"
  app_port = var.backend-alb["lb_port"]
  bastion_cidrs = var.bastion_cidrs
  component = var.backend-alb["component"]
  env = var.env
  instance_count = var.backend-alb["instance_count"]
  instance_type = var.backend-alb["instance_type "]
  kms_key = var.kms_key
  sg_cidrs = var.web_subnets
  subnets = module.vpc.app_subnets
  tags = var.tags
  vpc_id = module.vpc.vpc_id
}

