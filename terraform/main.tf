# Get details of the existing EC2 instance
data "aws_instance" "source" {
  instance_id = var.source_instance_id
}

# Create an AMI from the existing instance
resource "aws_ami_from_instance" "custom_ami" {
  name               = "custom-ami-${formatdate("YYYYMMDD-HHmmss", timestamp())}"
  source_instance_id = data.aws_instance.source.id
  description        = "AMI from ${var.source_instance_id}"

  lifecycle {
    create_before_destroy = true
  }
}

# Launch new EC2 instance from the AMI
resource "aws_instance" "new_instance" {
  ami                         = aws_ami_from_instance.custom_ami.id
  instance_type               = data.aws_instance.source.instance_type
  subnet_id                   = data.aws_instance.source.subnet_id
  vpc_security_group_ids      = data.aws_instance.source.vpc_security_group_ids
  key_name                    = data.aws_instance.source.key_name
  associate_public_ip_address = true

  tags = {
    Name = "new-cloud-module-server"
  }
}

# Create a new Elastic IP
resource "aws_eip" "new_eip" {
}

# Associate the Elastic IP with the new instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.new_instance.id
  allocation_id = aws_eip.new_eip.id
}
