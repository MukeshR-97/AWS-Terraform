plan_name        = "client-a-ec2-backup-plan"
vault_name       = "client-a-backup-vault"

ec2_instance_arn = "arn:aws:ec2:us-east-1:123456789012:instance/i-0abc123def456ghij"

schedule         = "cron(0 18 * * ? *)"
lifecycle_days   = 30