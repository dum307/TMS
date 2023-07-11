resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = var.template_subnet_id
  key_name = var.template_key_name
  vpc_security_group_ids = var.template_security_group_ids

  tags = {
    Name = var.template_tag_name
  }


connection {
    type     = "ssh"
    bastion_host = var.bastion_use ? var.bastion_ip : ""
    bastion_user = var.bastion_use ? var.bastion_user : ""
    bastion_private_key = var.bastion_use ? file(var.template_private_key_file_path) : ""
    user     = var.template_username
    private_key = file(var.template_private_key_file_path)
    host     = var.bastion_use ? self.private_ip : self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["echo 'Waiting for server to be initialized...'"]
  }

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook \
        -i '${self.private_ip},' \
        --ssh-common-args ' \
          -o ProxyCommand="ssh -o StrictHostKeyChecking=no -A -W %h:%p -q ubuntu@${aws_instance.bastion.public_ip} \
                               -i ${var.private_key_file_path}"' \
        -u ubuntu \
        --private-key ${var.private_key_file_path} \
        --extra-vars "efs_address=${module.efs.dns_name} \
                      wordpress_db_host=${module.db.db_instance_endpoint} \
                      wordpress_db_name=${var.rds_db_name} \
					            wordpress_db_user=${var.rds_username} \
					            wordpress_db_pass=${var.rds_password}" \
        ./playbooks/wp_back.yml
    EOT  
  }
}

resource "aws_ami_from_instance" "this" {
  name               = var.template_tag_name
  source_instance_id = aws_instance.this.id
}

resource "aws_launch_template" "this" {
  name = var.template_tag_name

  image_id = aws_ami_from_instance.this.id
  instance_initiated_shutdown_behavior = "stop"

  instance_type = "t2.micro"

  key_name = var.template_key_name

  vpc_security_group_ids = var.template_security_group_ids

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.template_tag_name
    }
  }
}