resource "aws_lb" "front" {
  name               = "${var.tags.Name}-frontend"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_target_group" "front" {
  name                 = "aws-targetgroup-frontend"
  vpc_id               = module.vpc.vpc_id
  port                 = 80
  protocol             = "HTTP"
  target_type          = "instance"
  health_check {
    matcher            = "200-399"
  }
}

resource "aws_lb_listener" "front_http" {
  load_balancer_arn = aws_lb.front.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front.arn
  }
}

locals {
  target_group_front_arn = aws_lb_target_group.front.arn
}
