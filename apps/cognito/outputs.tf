
output "user_pool_endpoint" {
  description = "Cognito UserPool Endpoint"

  value = aws_cognito_user_pool.main.endpoint
}

output "user_pool_web_client_id" {
  description = "Cognito UserPool WebClient Id"

  value = aws_cognito_user_pool_client.web-client.id
}


output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "user_pool_arn" {
  value = aws_cognito_user_pool.main.arn
}
