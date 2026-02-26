plan_name        = "client-a-ec2-backup-plan"
vault_name       = "client-a-backup-vault"

ec2_instance_arn = "arn:aws:ec2:ap-south-1:850995535715:instance/i-0ccd1b193af58f21e"

schedule         = "cron(0 18 * * ? *)"  # 11:30 PM IST
lifecycle_days   = 30