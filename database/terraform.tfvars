aws_region           = "ap-south-1"

client_name          = "client-a"
environment          = "prod"

vpc_id               = "vpc-03e87c703fd7b943d"
private_subnet_ids   = ["subnet-0f76082f733309ff3", "subnet-08a752328660b7098"]
allowed_sg_ids       = ["sg-09d26f45a1357fa50"]

db_name              = "appdb"
username             = "admin"
password             = "StrongPassword123!"

db_engine            = "mysql"
db_engine_version    = "8.0"
db_port              = 3306

db_instance_class    = "db.t3.medium"

db_logs              = ["error", "general", "slowquery"]

create_read_replica  = true