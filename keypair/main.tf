provider "aws" { region = var.aws_region }

# Generate a private/public key pair
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "this" {
  key_name   = "${var.client_name}-${var.environment}-key"
  public_key = tls_private_key.generated.public_key_openssh
}

# Save private key locally
resource "local_file" "private_key_pem" {
  content         = tls_private_key.generated.private_key_pem
  filename        = "${path.module}/${var.client_name}-${var.environment}-key.pem"
  file_permission = "0600"
}