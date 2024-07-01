output "vpc_id" {
  value = aws_vpc.resources_vpc.id
}

output "subnet_a_id" {
  value = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  value = aws_subnet.subnet_b.id
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value = aws_instance.ec2.id
}

output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value = aws_db_instance.default.endpoint
}
