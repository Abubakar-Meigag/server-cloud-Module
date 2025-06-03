# Launch a clean Amazon Linux 2 EC2
resource "aws_instance" "new_instance" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  user_data                   = file("${path.module}/user-data.sh")
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name

  tags = {
    Name = "ansible-cloud-module-server"
  }
}

# Create a new Elastic IP and associate it with the instance
resource "aws_eip" "new_eip" {
  instance = aws_instance.new_instance.id
}

resource "aws_ssm_parameter" "db_url" {
  name        = "/app/DB_URL"
  type        = "SecureString"
  value       = var.db_url
  description = "Full database URL with env format"
}