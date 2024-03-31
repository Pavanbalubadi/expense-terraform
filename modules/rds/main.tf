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

resource "aws_security_group" "main" {
  name        = "${var.env}-msql-rds"
  description = "${var.env}-msql-rds"
  vpc_id      = var.vpc_id

  ingress {
    description = "MYSQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.sg_cidrs
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags       = merge(var.tags, { Name = "${var.env}-msql-rds" })
}
