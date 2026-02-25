aws_region           = "us-east-1"
client_name          = "client-a"
environment          = "prod"

vpc_id               = "vpc-xxxxxxx"
private_subnet_ids   = ["subnet-aaa", "subnet-bbb"]
allowed_sg_ids       = ["sg-app"]

db_name              = "appdb"
username             = "admin"
password             = "StrongPassword123!"

db_engine            = "mysql"
db_engine_version    = "8.0"
db_port              = 3306

db_instance_class    = "db.t3.medium"
db_logs              = ["error", "general", "slowquery"]

create_read_replica  = true