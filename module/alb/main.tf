resource "aws_security_group" "main" {
  name        = "${var.env}-${var.component}"
  description = "${var.env}-${var.component}"
  vpc_id      = var. vpc_id

  ingress {
    description      = "app"
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = var.sg_cidrs
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags       = merge(var.tags, {Name ="${var.env}-${var.component}"})
}
resource "aws_lb" "main" {
  name               = "${var.env}-${var.component}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets
  tags               = merge(var.tags, {Name ="${var.env}-${var.component}"})

}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}

resource "aws_route53_record" "main" {
  zone_id       = aws_route53_zone_id
  name          = "www"
  type          = "CNAME"
  ttl           = 5
  records       = [aws_lb.main.id.dns_name]
}
variable "env" {}
variable "component" {}
variable "vpc_id" {}
variable "port" {}
variable "sg_cidrs" {}
variable "tags" {}
variable "subnets" {}
variable "target_group_arn" {}


