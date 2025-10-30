resource "aws_security_group" "rds" {
  vpc_id = var.vpc_id
  ingress = { 
    from_port = var.db_port
    to_port = var.db_port
    protocol = "tcp"
    cidr_blocks = var.cidr_blocks
  }
}

resource "aws_db_subnet_group" "main" {
  name = ""
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "main" {
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  db_name = var.db_name
  username = var.username
  password = var.password
  db_subnet_group_name = aws_db_subnet_group.main
  vpc_security_group_ids = [aws_security_group.rds.id]
  multi_az = true
  backup_retention_period = var.environment == "prod" ? 7 :1
  skip_final_snapshot = true
}