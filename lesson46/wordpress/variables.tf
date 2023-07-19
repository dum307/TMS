variable "tags" {
    type = map
    default = {
        Name = "dum307-wordpress"
        Project = "tms"
        Terraform = true

    }
}

variable "vpc_cidr_block" {
  type = string
}

variable "rds_db_name" {
    type = string
    default = "wordpress"
  
}

variable "rds_port" {
    type = string
    default = "3306"
}

variable "rds_username" {
    type = string
}

variable "rds_password" {
    type = string
    # sensitive = true
}

variable "efs_port" {
    type = string
    default = "2049"
}

variable "key_name" {
  type = string
}

variable "ssh_port" {
    type = string
    default = "22"
}

variable "http_port" {
    type = string
    default = "80"
}

variable "private_key_file_path" {
    type = string
}