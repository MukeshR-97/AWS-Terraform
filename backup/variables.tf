variable "plan_name" {}
variable "vault_name" {}
variable "resource_arn_list" { type = list(string) }
variable "schedule" {} # cron
variable "lifecycle_days" { type = number }