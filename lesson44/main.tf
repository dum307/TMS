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

resource "aws_key_pair" "key" {
  key_name   = "dum307_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChy4Knyh7RKt++lwvtjbxg0YQl6UzpIyS7ucQE2IJhwxnJ66yO/lyFt0JBshQzqt867aAmfxSsRbpHjcNveZkPxuIOAkZEfQhdVud0BGB3cVYswJwn/hTyQLBrfjdmT/J071zRL+uWcdhjh61b4339sn90X8813cSg8jaEfRy0xvkeIfERlc1KAH+x9eYz51yKDc9dx5SKb71dBW/VeXJTOPZq993tPWQ1izYTsVQ3sQZSrHlql7socvROU1hd5xPsjJ4lHoOlHWiGgtb9WPoqamVNkhnb2psOPdd7AKoYEpfXiUP871vArOvE13OAqhbX6KzNa0JRz7JqNSHHNHmD st-admin@tms"
}

resource "aws_instance" "public" {
  count = 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.public.id]
  associate_public_ip_address = true
  key_name = "dum307_key"
  user_data = file("init.sh")

  tags = {
    Name = "dum307 public"
  }

  depends_on = [

  aws_key_pair.key

  ]
}

resource "aws_instance" "private" {
  count = 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnets[0].id
  vpc_security_group_ids = [aws_security_group.private.id]
  associate_public_ip_address = true
  key_name = "dum307_key"
  user_data = file("init.sh")

  tags = {
    Name = "dum307 private"
  }

  depends_on = [

  aws_key_pair.key

  ]
}