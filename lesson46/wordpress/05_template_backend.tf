resource "aws_instance" "backend_image" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = module.vpc.private_subnets[0]
  key_name = "dum307_key"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]

  tags = {
    Name = "${var.tags.Name}-backend-template"
  }

connection {
    type     = "ssh"
    bastion_host = aws_instance.bastion.public_ip
    bastion_user = "ubuntu"
    bastion_private_key = file(var.private_key_file_path)
    user     = "ubuntu"
    private_key = file(var.private_key_file_path)
    host     = self.private_ip
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

resource "aws_ami_from_instance" "backend" {
  name               = "${var.tags.Name}-backend"
  source_instance_id = aws_instance.backend_image.id
}

resource "aws_ami_from_instance" "backend_new" {
  name               = "${var.tags.Name}-backend-new"
  source_instance_id = aws_instance.backend_image.id
}

resource "aws_launch_template" "backend" {
  name = "${var.tags.Name}-backend"

  # block_device_mappings {
  #   device_name = "/dev/sdf"

  #   ebs {
  #     volume_size = 20
  #   }
  # }

  # capacity_reservation_specification {
  #   capacity_reservation_preference = "open"
  # }

  # cpu_options {
  #   core_count       = 4
  #   threads_per_core = 2
  # }

  # credit_specification {
  #   cpu_credits = "standard"
  # }

  # disable_api_stop        = true
  # disable_api_termination = true

  # ebs_optimized = true

  # elastic_gpu_specifications {
  #   type = "test"
  # }

  # elastic_inference_accelerator {
  #   type = "eia1.medium"
  # }

  # iam_instance_profile {
  #   name = "test"
  # }

  image_id = aws_ami_from_instance.backend_new.id
  instance_initiated_shutdown_behavior = "stop"

  # instance_market_options {
  #   market_type = "spot"
  # }

  instance_type = "t2.micro"

  # kernel_id = "test"

  key_name = var.key_name

  # license_specification {
  #   license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
  # }

  # metadata_options {
  #   http_endpoint               = "enabled"
  #   http_tokens                 = "required"
  #   http_put_response_hop_limit = 1
  #   instance_metadata_tags      = "enabled"
  # }

  # monitoring {
  #   enabled = true
  # }

  # network_interfaces {
  #   associate_public_ip_address = true
  # }

  # placement {
  #   availability_zone = "us-west-2a"
  # }

  # ram_disk_id = "test"

  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.tags.Name}-backend"
    }
  }

  # user_data = filebase64("${path.module}/example.sh")
}