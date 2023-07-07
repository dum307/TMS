# Домашнее задание IaC 2

Создать с помощью Terraform 2 конфигурации AWS:

1. Создает VPC с public subnet
2. Создает EC2 instance в public subnet созданной на шаге 1 VPC

* В VPC вручную создать еще один EC2 instance и импортировать его в во вторую конфигурацию Terrafrom любым методом.

# Импорт EC2 instance

1. Создадим instance.

2. Создадим файл **import.tf** со следующим содержимым:

```
 import {
   id = "i-0b326b40f86ac8d66"
   to = aws_instance.import
 }
```
**id** - id инстанса

3. Выполним команду

```terraform plan -generate-config-out=generated.tf```

4. В результате получим файл **generated.tf** со следующим содержимым:
```
# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "import" {
  ami                                  = "ami-04e601abe3e1a910f"
  associate_public_ip_address          = true
  availability_zone                    = "eu-central-1a"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "dum307_key"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "10.0.1.21"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-0878d0e5eb60623de"
  tags = {
    Name = "dum307 import"
  }
  tags_all = {
    Name = "dum307 import"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-097a5ba70c5312e64"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 1
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 100
    kms_key_id            = null
    tags                  = {}
    throughput            = 0
    volume_size           = 8
    volume_type           = "gp2"
  }
}
```

5. Выполним ```terraform apply```, и в результате импортированный ресурс появится в конфигурации **terraform.tfstate**
