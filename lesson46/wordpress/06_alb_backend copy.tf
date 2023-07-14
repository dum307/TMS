resource "aws_lb" "back" {
  name               = "${var.tags.Name}-backend"
  load_balancer_type = "application"
  internal           = true
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = module.vpc.private_subnets
}

resource "aws_lb_target_group" "back" {
  name                 = "aws-targetgroup-backend"
  vpc_id               = module.vpc.vpc_id
  port                 = 80
  protocol             = "HTTP"
  target_type          = "instance"
  health_check {
    matcher            = "200-399"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.back.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back.arn
  }
}

locals {
  target_group_back_arn = aws_lb_target_group.back.arn
  aws_lb_back_dns_name  = aws_lb.back.dns_name
}

output "aws_lb_back_dns_name" {
    value = local.aws_lb_back_dns_name
}