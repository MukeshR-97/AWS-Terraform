variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "client_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "target_instance_ids" { type = list(string) }