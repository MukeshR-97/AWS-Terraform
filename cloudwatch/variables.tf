variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "client_name" {
  description = "Client name"
  type        = string
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "instance_id" {
  description = "EC2 Instance ID"
  type        = string
}

variable "alert_email" {
  description = "Email for SNS notifications"
  type        = string
}

variable "disk_fstype" {
  description = "Filesystem type (xfs/ext4)"
  type        = string
  default     = "xfs"
}