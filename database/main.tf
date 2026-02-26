provider "aws" {
  region = var.aws_region
}

############################################
# KMS KEY
############################################

resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "rds_alias" {
  name          = "alias/${var.client_name}-${var.environment}-rds"
  target_key_id = aws_kms_key.rds.key_id
}

############################################
# SECRETS MANAGER (DB PASSWORD)
############################################

resource "aws_secretsmanager_secret" "db_secret" {
  name = "${var.client_name}-${var.environment}-db-credentials"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id

  secret_string = jsonencode({
    username = var.username
    password = var.password
  })
}

############################################
# SECURITY GROUP
############################################

resource "aws_security_group" "rds_sg" {
  name   = "${var.client_name}-${var.environment}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = var.allowed_sg_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

############################################
# SUBNET GROUP
############################################

resource "aws_db_subnet_group" "db" {
  name       = "${var.client_name}-${var.environment}-subnet-group"
  subnet_ids = var.private_subnet_ids
}

############################################
# ENHANCED MONITORING ROLE
############################################

resource "aws_iam_role" "rds_monitoring" {
  name = "${var.client_name}-${var.environment}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

############################################
# PRIMARY RDS INSTANCE
############################################

resource "aws_db_instance" "primary" {

  identifier              = "${var.client_name}-${var.environment}-db"

  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class

  allocated_storage       = 100
  max_allocated_storage   = 300
  storage_type            = "gp3"
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.rds.arn

  db_name   = var.db_name
  username  = var.username
  password  = var.password

  port                    = var.db_port
  multi_az                = true
  publicly_accessible     = false

  db_subnet_group_name    = aws_db_subnet_group.db.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  backup_retention_period = 30
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  auto_minor_version_upgrade      = true
  copy_tags_to_snapshot = true

  deletion_protection     = true
  skip_final_snapshot     = false
  final_snapshot_identifier = "${var.client_name}-${var.environment}-final-snapshot"

  performance_insights_enabled = true
  monitoring_interval          = 60
  monitoring_role_arn          = aws_iam_role.rds_monitoring.arn

  enabled_cloudwatch_logs_exports = var.db_logs

  iam_database_authentication_enabled = true

  apply_immediately = false

  tags = {
    Name        = "${var.client_name}-${var.environment}-rds"
    Environment = var.environment
  }
}

############################################
# OPTIONAL READ REPLICA
############################################

resource "aws_db_instance" "replica" {
  count               = var.create_read_replica ? 1 : 0

  identifier          = "${var.client_name}-${var.environment}-replica"
  replicate_source_db = aws_db_instance.primary.identifier
  instance_class      = var.db_instance_class

  publicly_accessible = false

  auto_minor_version_upgrade = true
  monitoring_interval        = 60
  monitoring_role_arn        = aws_iam_role.rds_monitoring.arn

  skip_final_snapshot = true
}