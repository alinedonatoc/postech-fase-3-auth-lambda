resource "aws_cognito_user_pool" "pool" {
  name = "minha-api-user-pool"
}
resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "minha-api-serverless-exemplo"
  user_pool_id = aws_cognito_user_pool.pool.id
}
resource "aws_cognito_resource_server" "resource_server" {
  identifier   = "minha-api"
  name         = "resource-server-minha-api"
  user_pool_id = aws_cognito_user_pool.pool.id
  scope {
    scope_name        = "sms"
    scope_description = "Todos os recursos"
  }
}
resource "aws_cognito_user_pool_client" "client" {
  name                                 = "minha-api-client"
  user_pool_id                         = aws_cognito_user_pool.pool.id
  generate_secret                      = true
  explicit_auth_flows                  = ["ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes                 = ["minha-api/sms"]
  supported_identity_providers         = ["COGNITO"]
  depends_on                           = [aws_cognito_resource_server.resource_server]
}