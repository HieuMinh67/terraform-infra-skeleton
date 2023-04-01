variable "lambda_function_invoke_arn" {}
variable "lambda_function_name" {}
variable "apigateway_execution_arn" {} # aws_apigatewayv2_api.example.execution_arn
variable "apigateway_id" {}            #  aws_apigatewayv2_api.example.id
variable "apigateway_name" {}

variable "service_routes" {
  type = list(object({
    method = string
    path   = string
  }))
}

variable "authorizer_id" {
  nullable = true
}