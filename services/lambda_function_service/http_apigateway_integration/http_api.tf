# Per route of service
resource "aws_apigatewayv2_route" "this" {
  for_each = { for index, route in var.service_routes : "${route.method}-${route.path} " => route }

  api_id = var.apigateway_id
  # route_key = "$default"
  route_key          = "${each.value.method} ${each.value.path}"
  target             = "integrations/${aws_apigatewayv2_integration.this.id}"
  authorization_type = "JWT"
  authorizer_id      = var.authorizer_id
}

# Per Service aka Lambda
resource "aws_apigatewayv2_deployment" "this" {
  api_id      = var.apigateway_id # aws_apigatewayv2_route.this.api_id
  description = var.lambda_function_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowAPIGatewayInvokeFor${title(var.apigateway_name)}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name # aws_lambda_function.this.function_name # function_full_name
  principal     = "apigateway.amazonaws.com"
  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${var.apigateway_execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "this" {
  api_id           = var.apigateway_id
  integration_type = "AWS_PROXY"

  connection_type    = "INTERNET"
  description        = var.lambda_function_name
  integration_method = "POST"
  integration_uri    = var.lambda_function_invoke_arn
}