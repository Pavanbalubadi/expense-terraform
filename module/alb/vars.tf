variable "env" {}
variable "component" {}
variable "vpc_id" {}
variable "port" {}
variable "sg_cidrs" {}
variable "tags" {}
variable "subnets" {}
variable "target_group_arn" {}
variable "internal" {}
variable "dns_name" {
  default = null
}