terraform {
  required_version = "~> 1.6"
  backend "s3" {
    bucket  = "tf-state-api-testing-bucket"
    key     = "api-testing.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
