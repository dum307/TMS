module "template" {
  source = "./modules/template"

  template_subnet_id            = module.vpc.private_subnets[0]
  template_security_group_ids   = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]

  bastion_ip                    = aws_instance.bastion.public_ip
  bastion_user                  = "ubuntu"
  template_username             = "ubuntu"
  playbook_path                 = "./playbooks/wp_back.yml"
  db_instance_endpoint          = module.db.db_instance_endpoint
  efs_dns_name                  = module.efs.dns_name
  rds_db_name                   = "wordpress"
  rds_username                  = "admin"
  rds_password                  = "password"

  template_key_name             = var.key_name
  template_tag_name             = var.tags.Name

}