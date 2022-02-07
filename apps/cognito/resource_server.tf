resource "aws_cognito_resource_server" "main" {
  identifier = "main-server"
  name       = "main-resource"

  scope {
    scope_name        = "main-scope"
    scope_description = "the main Scope Description"
  }

  user_pool_id = aws_cognito_user_pool.main.id
}
