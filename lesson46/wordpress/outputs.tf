output "subnets_cidr_blocks" {
    value = local.subnets_cidr_blocks
}

output "private_subnet_ids" {
    value = module.vpc.private_subnets
}