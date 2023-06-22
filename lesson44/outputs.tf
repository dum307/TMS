output "public_ip" {
  value = aws_instance.public[0].public_ip
}

output "private_ip" {
  value = aws_instance.private[0].public_ip
}
