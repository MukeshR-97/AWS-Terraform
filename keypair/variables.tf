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