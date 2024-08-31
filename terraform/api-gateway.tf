resource "aws_api_gateway_rest_api" "api" {
  name        = "api-testing"
  description = "API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "backend" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{proxy+}"
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "api" {
  resource_id      = aws_api_gateway_resource.backend.id
  rest_api_id      = aws_api_gateway_rest_api.api.id
  http_method      = "ANY"
  authorization    = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

# resource "aws_api_gateway_integration" "api_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.api.id
#   resource_id             = aws_api_gateway_resource.backend.id
#   http_method             = aws_api_gateway_method.api.http_method
#   integration_http_method = "ANY"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.lambda_api_function.invoke_arn

#   # request_parameters = {
#   #   "integration.request.path.proxy" = "method.request.path.proxy"
#   # }
# }

# # Define the API Gateway deployment
# resource "aws_api_gateway_deployment" "api_deployment" {
#   depends_on = [aws_api_gateway_integration.api_integration]

#   rest_api_id = aws_api_gateway_rest_api.api.id
#   stage_name  = "dev"
# }

# resource "aws_api_gateway_stage" "api_stage" {
#   rest_api_id  = aws_api_gateway_rest_api.api.id
#   stage_name   = "dev"
#   deployment_id = aws_api_gateway_deployment.api_deployment.id
# }