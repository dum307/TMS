output "subnets_cidr_blocks" {
    value = local.subnets_cidr_blocks
}

output "private_subnet_ids" {
    value = module.vpc.private_subnets
}

output "aws_lb_front_dns_name" {
    value = aws_lb.front.dns_name
}