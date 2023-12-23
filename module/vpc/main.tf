resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags       = merge(var.tags, {Name=var.env})
}
resource "aws_subnet" "main" {
  count      = length(var.public_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.app_subnets[count.index]
  tags       = merge(var.tags, {Name="public_subnets"})
  availability_zone = var.azs[count.index]
}