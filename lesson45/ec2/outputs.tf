output "public_ip" {
  value = aws_instance.public[0].public_ip
}

output "data_subnets" {
  value = data.aws_subnets.public.ids[0]
}

output "security_groups" {
  value = data.aws_security_groups.sg.ids
}

output "key_pair" {
  value = aws_key_pair.key.key_name
}

output "instance_ids" {
  value = data.aws_instances.ids.ids
}
