module "template_frontend" {
  source = "./modules/template"

  template_subnet_id                   = module.vpc.public_subnets[0]
  template_associate_public_ip_address = "true"
  template_security_group_ids          = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]

  bastion_ip                           = aws_instance.bastion.public_ip
  bastion_user                         = "ubuntu"
  template_username                    = "ubuntu"
  playbook_path                        = "./playbooks/wp_front.yml"
  aws_lb_back_dns_name                 = local.aws_lb_back_dns_name
  template_type                        = "frontend"
  nginx_listen_port                    = "80"

  template_private_key_file_path       = var.private_key_file_path
  template_key_name                    = var.key_name
  template_tag_name                    = "dum307-template-frontend" 

  depends_on = [
    aws_lb.back
  ]
}