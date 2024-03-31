resource "aws_db_parameter_group" "main" {
  name   = "${var.env}-msql-rds"
  family = "mysql5.7"
  tags   = merge(var.tags, { Name = "${var.env}-msql-rds" })
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.env}-msql-rds"
  subnet_ids = var.subnets
  tags       = merge(var.tags, { Name = "${var.env}-msql-rds" })
}

