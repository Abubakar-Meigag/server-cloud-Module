output "new_instance_id" {
  value       = aws_instance.new_instance.id
  description = "ID of the newly created EC2 instance"
}

output "elastic_ip" {
  value       = aws_eip.new_eip.public_ip
  description = "Elastic IP of the new EC2 instance"
}
output "db_url_parameter_name" {
  value       = aws_ssm_parameter.db_url.name
  description = "Name of the SSM parameter storing the database URL"
}