output "primary_endpoint" {
  value = aws_db_instance.primary.endpoint
}

output "replica_endpoint" {
  value = aws_db_instance.replica[*].endpoint
}

output "secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}