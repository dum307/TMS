data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_count = length(data.aws_availability_zones.available.names)
  subnet_types = ["public", "private"]
  bits = ceil(log(local.az_count * length(local.subnet_types), 2))

  subnets_cidr_blocks = {
    for i, name in local.subnet_types :
    "${name}" => [
        for subnet_num in range (i * local.az_count, (i + 1) * local.az_count) :
            cidrsubnet(var.vpc_cidr_block, local.bits, subnet_num)   
    ]
  }
}

module "vpc" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"

  name = var.tags.Name
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = local.subnets_cidr_blocks.private
  public_subnets  = local.subnets_cidr_blocks.public

  enable_nat_gateway = true
  single_nat_gateway = true

}