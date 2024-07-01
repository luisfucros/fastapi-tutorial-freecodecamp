# RDS instance
resource "aws_db_instance" "default" {
  allocated_storage      = 20
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  db_name                = "api_db"
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  storage_type           = "gp2"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  db_subnet_group_name = aws_db_subnet_group.subnet_group.name

  skip_final_snapshot = true

  tags = merge(
    local.common_tags,
    {
      Name = var.rds_instance_name
    }
  )
}
