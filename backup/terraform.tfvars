plan_name        = "client-a-backup-plan"
vault_name       = "client-a-backup-vault"
resource_arn_list = [
  "arn:aws:rds:us-east-1:123456789012:db:clientadb",
  "arn:aws:ec2:us-east-1:123456789012:volume/vol-xxxxxxxx",
  "arn:aws:s3:::client-a-bucket"
]
schedule         = "cron(0 5 ? * MON-FRI *)"   # daily Mon-Fri at 5 AM UTC
lifecycle_days   = 30