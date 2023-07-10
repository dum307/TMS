resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow MYSQL inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = var.rds_port
    to_port          = var.rds_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.tags.Name

  engine            = "mysql"
  engine_version    = "8.0.32"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = var.rds_db_name
  username = var.rds_username
  password = var.rds_password
  port     = var.rds_port

#   iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.allow_mysql.id]


  create_monitoring_role = false
  create_db_option_group = false
  create_db_parameter_group = false
  manage_master_user_password = false


  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

#   # DB parameter group
#   family = "mysql5.7"

  # DB option group
#   major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

#   parameters = [
#     {
#       name  = "character_set_client"
#       value = "utf8mb4"
#     },
#     {
#       name  = "character_set_server"
#       value = "utf8mb4"
#     }
#   ]

#   options = [
#     {
#       option_name = "MARIADB_AUDIT_PLUGIN"

#       option_settings = [
#         {
#           name  = "SERVER_AUDIT_EVENTS"
#           value = "CONNECT"
#         },
#         {
#           name  = "SERVER_AUDIT_FILE_ROTATIONS"
#           value = "37"
#         },
#       ]
#     },
#   ]
}
