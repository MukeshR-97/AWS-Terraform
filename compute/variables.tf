variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "client_name" {
  description = "Client name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, etc)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID from networking module"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID from networking module"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID from networking module"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "keypair for EC2 instances"
  type        = string
}