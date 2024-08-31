resource "aws_lambda_function" "lambda_api_function" {
  function_name = var.lambda_function_name

  role = aws_iam_role.lambda_model_role.arn

  image_uri    = "${aws_ecr_repository.ecr.repository_url}:${var.image_version}"
  package_type = "Image"

  memory_size = 512

  vpc_config {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = [aws_subnet.subnet_a.id]
  }

  # Uncomment the next line if you have an M1 processor
  # architectures = [ "arm64" ] 
  environment {
    variables = {
      DATABASE_HOSTNAME     = aws_db_instance.api_rds.address
      DATABASE_NAME         = aws_db_instance.api_rds.db_name
      DATABASE_USERNAME     = var.db_username
      DATABASE_PASSWORD     = var.db_password
      DATABASE_PORT         = var.db_port
      SECRET_KEY            = var.secret_key
      ALGORITHM             = var.algorithm
      ACCESS_TOKEN_EXPIRE_MINUTES = var.access_token_expire_minutes
    }
  }
}

