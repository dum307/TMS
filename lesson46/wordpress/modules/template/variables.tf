# variable "template_type" {
#     type = string
#     description = "frontend or backend"
# }

variable "template_subnet_id" {
    type = string
}

variable "template_key_name" {
    type = string
}

variable "template_security_group_ids" {
    type = list
}

variable "template_tag_name" {
    type = string
}

variable "template_username" {
    type = string
}
variable "bastion_use" {
    type = bool
    default = true
}
variable "bastion_ip" {
    type = string
}
variable "bastion_user" {
    type = string
}
variable "template_private_key_file_path" {
    type = string
}
variable "playbook_path" {
    type = string
}
variable "efs_dns_name" {
    type = string
}
variable "db_instance_endpoint" {
    type = string
}
variable "rds_db_name" {
    type = string
}
variable "rds_username" {
    type = string
}
variable "rds_password" {
    type = string
}



