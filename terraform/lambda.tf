resource "aws_lambda_function" "lambda_model_function" {
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
      DATABASE_HOSTNAME     = aws_db_instance.default.address
      DATABASE_NAME         = aws_db_instance.default.db_name
      DATABASE_USERNAME     = var.db_username
      DATABASE_PASSWORD     = var.db_password
      DATABASE_PORT         = "5432"
      SECRET_KEY            = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
      ALGORITHM             = "HS256"
      ACCESS_TOKEN_EXPIRE_MINUTES="120"
    }
  }
}

# provide role with no access policy initially
resource "aws_iam_role" "lambda_model_role" {
  name = "lambda-model-role-testing"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_model_policy_attachement" {
  role       = aws_iam_role.lambda_model_role.name
  policy_arn = aws_iam_policy.lambda_model_policy.arn
}

resource "aws_iam_policy" "lambda_model_policy" {
  name = "lambda-model-policy-testing"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "rds:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:AttachNetworkInterface"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}