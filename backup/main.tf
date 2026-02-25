provider "aws" { region = "us-east-1" }

resource "aws_backup_vault" "this" { name = var.vault_name }

resource "aws_backup_plan" "this" {
  name = var.plan_name

  rule {
    rule_name         = "${var.plan_name}-rule"
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.schedule
    lifecycle { delete_after = var.lifecycle_days }
  }
}

resource "aws_iam_role" "backup_role" {
  name = "${var.plan_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{ Effect="Allow", Principal={Service="backup.amazonaws.com"}, Action="sts:AssumeRole" }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_attach" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_selection" "this" {
  name         = "${var.plan_name}-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.this.id
  resources    = var.resource_arn_list
}