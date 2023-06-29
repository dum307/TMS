resource "aws_key_pair" "key" {
  key_name   = "dum307_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChy4Knyh7RKt++lwvtjbxg0YQl6UzpIyS7ucQE2IJhwxnJ66yO/lyFt0JBshQzqt867aAmfxSsRbpHjcNveZkPxuIOAkZEfQhdVud0BGB3cVYswJwn/hTyQLBrfjdmT/J071zRL+uWcdhjh61b4339sn90X8813cSg8jaEfRy0xvkeIfERlc1KAH+x9eYz51yKDc9dx5SKb71dBW/VeXJTOPZq993tPWQ1izYTsVQ3sQZSrHlql7socvROU1hd5xPsjJ4lHoOlHWiGgtb9WPoqamVNkhnb2psOPdd7AKoYEpfXiUP871vArOvE13OAqhbX6KzNa0JRz7JqNSHHNHmD st-admin@tms"
}

resource "aws_instance" "public" {
  count = 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.public.ids[0]
  vpc_security_group_ids = [data.aws_security_groups.sg.ids[0]]
  associate_public_ip_address = true
  key_name = "dum307_key"

  tags = {
    Name = "dum307 public"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true
  }

  depends_on = [

  aws_key_pair.key

  ]
}