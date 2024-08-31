resource "aws_ecr_repository" "ecr" {
  name = var.repository_name

  tags = local.common_tags
}
