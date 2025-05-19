output "new_instance_id" {
  value       = aws_instance.new_instance.id
  description = "ID of the newly created EC2 instance"
}

output "new_instance_public_ip" {
  value       = aws_instance.new_instance.public_ip
  description = "Public IP of the new EC2 instance"
}

output "ami_id" {
  value       = aws_ami_from_instance.custom_ami.id
  description = "AMI ID created from the source instance"
}

output "elastic_ip" {
  value       = aws_eip.new_eip.public_ip
  description = "Elastic IP associated with the new instance"
}