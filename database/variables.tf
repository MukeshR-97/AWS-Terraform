variable "aws_region" { type = string }

variable "client_name" { type = string }

variable "environment" { type = string }

variable "vpc_id" { type = string }

variable "private_subnet_ids" {
  type = list(string)
}

variable "allowed_sg_ids" {
  description = "Security groups allowed to access RDS"
  type        = list(string)
}

variable "db_name" { type = string }

variable "username" {
  type      = string
  sensitive = true
}

variable "password" {
  type      = string
  sensitive = true
}

variable "db_engine" {
  description = "mysql | postgres | mariadb"
  type        = string
}

variable "db_engine_version" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "db_logs" {
  type = list(string)
}

variable "create_read_replica" {
  type    = bool
  default = false
}