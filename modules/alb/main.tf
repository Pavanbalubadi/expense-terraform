resource "aws_security_group" "main" {
  name        = "${var.env}-${var.component}"
  description = "${var.env}-${var.component}"
  vpc_id      = var.vpc_id

  ingress {
    description = "APP"
    from_port   = var.lb_port
    to_port     = var.lb_port
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

  tags       = merge(var.tags, { Name = "${var.env}-${var.component}-alb" })
}
resource "aws_lb" "main" {
  name               = "${var.env}-${var.component}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets
  tags       = merge(var.tags, { Name = "${var.env}-${var.component}-alb" })
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}


