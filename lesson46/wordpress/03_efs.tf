# resource "aws_security_group" "allow_efs" {
#   name        = "allow_efs"
#   description = "Allow EFS inbound traffic"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     from_port        = var.efs_port
#     to_port          = var.efs_port
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow_efs"
#   }
# }

# module "efs" {
#   source = "git@github.com:cloudposse/terraform-aws-efs.git"
#   # Cloud Posse recommends pinning every module to a specific version
#   # version     = "x.x.x"

#   namespace = var.tags.Name
#   stage     = "dev"
#   name      = var.tags.Name
#   region    = "eu-central-1"
#   vpc_id    = module.vpc.vpc_id
#   subnets   = module.vpc.private_subnets
# #   zone_id   = [var.aws_route53_dns_zone_id]

#   # allowed_security_group_ids = [aws_security_group.allow_efs.id]
#   associated_security_group_ids = [aws_security_group.allow_efs.id]
# }