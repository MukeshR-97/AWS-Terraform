terraform {
  backend "s3" {
    bucket         = "central-terraform-state-prod"
    key            = "client-a/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

then, How to Initialize Correctly
Inside:
clients/client-a/

Run:
terraform init
terraform plan
terraform apply

If backend already exists:
terraform init -reconfigure
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"