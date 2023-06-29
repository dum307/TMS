data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Owner"
    values = ["Dmitry Urazalin"]
  }
}

data "aws_security_groups" "sg" {
  tags = {
    Owner = "Dmitry Urazalin"
  }
}

# data "aws_instances" "ids" {
#   filter {
#     name   = "tag:Owner"
#     values = ["Dmitry Urazalin"] 
#   }
# }