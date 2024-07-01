# EC2 instance
resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_http_traffic.id]
  subnet_id              = aws_subnet.subnet_a.id
  associate_public_ip_address = true

  tags = merge(
    local.common_tags,
    {
      Name = var.instance_name
    }
  )
}
