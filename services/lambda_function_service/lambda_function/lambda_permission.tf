# resource "aws_lambda_permission" "this-query-gateway" {
#   statement_id  = "AllowQueryAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.this.function_name # function_full_name
#   principal     = "apigateway.amazonaws.com"
#   # The "/*/*" portion grants access from any method on any resource
#   # within the API Gateway REST API.
#   source_arn = var.query_api_source_arn
# }

# resource "aws_lambda_permission" "this-mutation-gateway" {
#   statement_id  = "AllowMutationAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.this.function_name # function_full_name
#   principal     = "apigateway.amazonaws.com"
#   # The "/*/*" portion grants access from any method on any resource
#   # within the API Gateway REST API.
#   source_arn = var.mutation_api_source_arn
# }
