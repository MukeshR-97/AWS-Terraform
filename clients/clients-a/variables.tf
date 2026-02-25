variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "client_name" {
  type        = string
  description = "Client identifier"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet CIDRs"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "ami_id" {
  type        = string
  description = "AMI ID"
}

variable "public_key" {
  type        = string
  description = "SSH public key"
}