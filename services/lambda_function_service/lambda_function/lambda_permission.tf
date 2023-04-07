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

resource "aws_cloudwatch_event_rule" "cron_job" {
  name                = "aws-nuke-cron-job"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda_on_schedule" {
  arn  = aws_lambda_function.this.arn
  rule = aws_cloudwatch_event_rule.cron_job.name
}

resource "aws_lambda_permission" "allow-cloudwatch-to-call-split-lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_job.arn
}
