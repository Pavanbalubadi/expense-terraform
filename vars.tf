variable "env" {}
variable "tags" {}
variable "vpc_cidr_block" {}
variable "public_subnets" {}
variable "azs" {}
variable "db_subnets" {}
variable "web_subnets" {}
variable "account_id" {}
variable "default_route_table_id" {}

##rds
variable "subnets" {}
variable "sg_cidrs" {}
variable "kms_key" {}
variable "rds_allocated_storage" {}
variable "rds_engine" {}
variable "rds_instance_class" {}
variable "rds_engine_version" {}

##backend(app)
variable "app_port" {}
variable "bastion_cidrs" {}
variable "component" {}
variable "instance_count" {}
variable "instance_type" {}