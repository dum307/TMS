# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"

#   name = "${var.tags.Name}-backend"

#   load_balancer_type = "application"

#   vpc_id             = module.vpc.vpc_id
#   subnets            = module.vpc.private_subnets
#   security_groups    = [aws_security_group.allow_http.id]

# #   access_logs = {
# #     bucket = "my-alb-logs"
# #   }

#   target_groups = [
#     {
#       name_prefix      = "pref-"
#       backend_protocol = "HTTP"
#       backend_port     = 80
#       target_type      = "instance"
#       targets = {}
#       health_check = {
#         matcher = "200-399"
#       }
#     }
#   ]

# #   https_listeners = [
# #     {
# #       port               = 443
# #       protocol           = "HTTPS"
# #       certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
# #       target_group_index = 0
# #     }
# #   ]

#   http_tcp_listeners = [
#     {
#       port               = 80
#       protocol           = "HTTP"
#       target_group_index = 0
#     }
#   ]

# }