output "vpc_cidr" {
    value = aws_vpc.main.cidr_block
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "subnets_ids" {
    value = aws_subnet.public_subnets[*].id
}

output "subnets_cidrs" {
    value = aws_subnet.public_subnets[*].cidr_block
}

output "internet_gateway_id" {
    value = aws_internet_gateway.gw.id
}

output "security_group" {
    value = aws_security_group.public.id
}