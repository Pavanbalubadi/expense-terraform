resource "aws_lb" "test" {
  name               = "${var.env}-${var.component}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnets
  tags = {
    Environment = "production"
  }
}