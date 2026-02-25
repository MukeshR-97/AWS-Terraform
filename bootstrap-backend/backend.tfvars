bucket         = "terraform-state-prod-client-a"
key            = "bootstrap/terraform.tfstate"
region         = "ap-south-1"
dynamodb_table = "terraform-lock-table-client-a"
encrypt        = true