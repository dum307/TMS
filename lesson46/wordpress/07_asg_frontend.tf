module "asg_front" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "${var.tags.Name}-frontend"

  min_size                  = 2
  max_size                  = 3
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.public_subnets

#   initial_lifecycle_hooks = [
#     {
#       name                  = "ExampleStartupLifeCycleHook"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 60
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
#       notification_metadata = jsonencode({ "hello" = "world" })
#     },
#     {
#       name                  = "ExampleTerminationLifeCycleHook"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 180
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
#       notification_metadata = jsonencode({ "goodbye" = "world" })
#     }
#   ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  create_launch_template = false
  launch_template        = module.template_frontend.launch_template_name

  target_group_arns = [local.target_group_front_arn]

  # target_group_arns = module.alb.target_group_arns

#   update_default_version      = true

#   image_id          = "ami-ebd02392"
#   instance_type     = "t3.micro"
#   ebs_optimized     = true
#   enable_monitoring = true

  # IAM role & instance profile
#   create_iam_instance_profile = true
#   iam_role_name               = "example-asg"
#   iam_role_path               = "/ec2/"
#   iam_role_description        = "IAM role example"
#   iam_role_tags = {
#     CustomIamRole = "Yes"
#   }
#   iam_role_policies = {
#     AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   }

#   block_device_mappings = [
#     {
#       # Root volume
#       device_name = "/dev/xvda"
#       no_device   = 0
#       ebs = {
#         delete_on_termination = true
#         encrypted             = true
#         volume_size           = 20
#         volume_type           = "gp2"
#       }
#     }, {
#       device_name = "/dev/sda1"
#       no_device   = 1
#       ebs = {
#         delete_on_termination = true
#         encrypted             = true
#         volume_size           = 30
#         volume_type           = "gp2"
#       }
#     }
#   ]

#   capacity_reservation_specification = {
#     capacity_reservation_preference = "open"
#   }

#   cpu_options = {
#     core_count       = 1
#     threads_per_core = 1
#   }

#   credit_specification = {
#     cpu_credits = "standard"
#   }

#   instance_market_options = {
#     market_type = "spot"
#     spot_options = {
#       block_duration_minutes = 60
#     }
#   }

#   metadata_options = {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 32
#   }

#   network_interfaces = [
#     {
#       delete_on_termination = true
#       description           = "eth0"
#       device_index          = 0
#       security_groups       = ["sg-12345678"]
#     },
#     {
#       delete_on_termination = true
#       description           = "eth1"
#       device_index          = 1
#       security_groups       = ["sg-12345678"]
#     }
#   ]

#   placement = {
#     availability_zone = "us-west-1b"
#   }

#   tag_specifications = [
#     {
#       resource_type = "instance"
#       tags          = { WhatAmI = "Instance" }
#     },
#     {
#       resource_type = "volume"
#       tags          = { WhatAmI = "Volume" }
#     },
#     {
#       resource_type = "spot-instances-request"
#       tags          = { WhatAmI = "SpotInstanceRequest" }
#     }
#   ]

#   tags = {
#     Environment = "dev"
#     Project     = "megasecret"
#   }
}