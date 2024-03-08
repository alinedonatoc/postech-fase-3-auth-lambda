resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "Minha API"
  description = "AWS Rest API de exemplo com Terraform"
  endpoint_configuration {
   types = ["REGIONAL"]
  }
}
resource "aws_api_gateway_authorizer" "authorizer" {
  name          = "cognito"
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.pool.arn]
}