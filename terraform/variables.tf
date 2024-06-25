variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_a_cidr" {
  description = "The CIDR block for subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_b_cidr" {
  description = "The CIDR block for subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "main-vpc"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "rds_instance_name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "The project name tag for resources"
  type        = string
  default     = "api-testing"
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "dev"
}