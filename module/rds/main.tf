resource "aws_db_parameter_group" "main" {
  name   = "${var.env}-mysql-rds"
  family = "mysql5.7"
  tags = merge(var.tags, {Name ="${var.env}-mysql-rds"})
}

resource "aws_db_instance" "main" {
  allocated_storage    = var.rds_allocated_storage
  db_name              = "mysql"
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = aws_db_parameter_group.main.name
  skip_final_snapshot  = true
  multi_az             = file() ##(for me )
  identifier           = "${var.env}-mysql-rds"
  storage_type         = "gp3"
}








