# VPC
resource "aws_vpc" "api_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = var.vpc_name
    }
  )
}

# Subnets
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.api_vpc.id
  cidr_block        = var.subnet_a_cidr
  availability_zone = "${var.aws_region}a"

  tags = merge(
    local.common_tags,
    {
      Name = "subnet-a"
    }
  )
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.api_vpc.id
  cidr_block        = var.subnet_b_cidr
  availability_zone = "${var.aws_region}b"

  tags = merge(
    local.common_tags,
    {
      Name = "subnet-b"
    }
  )
}

# Subnet Group
resource "aws_db_subnet_group" "subnet_group" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = merge(
    local.common_tags,
    {
      Name = "Main subnet group"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.api_vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-igw"
    }
  )
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.api_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "public-rt"
    }
  )
}

# Associate Subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.public.id
}
