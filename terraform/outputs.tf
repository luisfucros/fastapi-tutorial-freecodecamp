output "vpc_id" {
  value = aws_vpc.api_vpc.id
}

output "subnet_a_id" {
  value = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  value = aws_subnet.subnet_b.id
}

output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value = aws_db_instance.api_rds.endpoint
}
