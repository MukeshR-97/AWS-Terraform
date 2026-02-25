#Run bootstrap first:
cd bootstrap
terraform init
terraform apply

#Use outputs from bootstrap to configure each client backend:
terraform {
  backend "s3" {
    bucket         = "central-terraform-state-prod-123456"  # from bootstrap output
    key            = "client-a/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"               # from bootstrap output
    encrypt        = true
  }
}

terraform init -var-file="terraform.tfvars"
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"


terraform init -backend-config="backend.tfvars"
terraform plan
terraform apply