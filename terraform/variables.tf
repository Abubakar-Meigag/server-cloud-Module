variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}
variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate"
  type        = list(string)
}
variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}
variable "db_url" {
  description = "Full database URL with env format"
  type        = string
  sensitive   = true
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string

}
