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
  count = var.lambda_schedule_expression != "" ? 1 : 0
  name                = "aws-nuke-cron-job"
  schedule_expression = var.lambda_schedule_expression
}

resource "aws_cloudwatch_event_target" "trigger_lambda_on_schedule" {
  count = var.lambda_schedule_expression != "" ? 1 : 0
  arn   = aws_lambda_function.this.arn
  rule  = aws_cloudwatch_event_rule[0].cron_job.name
  input = "{\"account_id\": \"${var.target_account["account_id"]}\", \"access_key\": \"${var.target_account["access_key"]}\", \"secret_key\": \"${var.target_account["secret_key"]}\", \"iam_username\": \"${var.target_account["iam_username"]}\"}"
}

resource "aws_lambda_permission" "allow-cloudwatch-to-call-split-lambda" {
  count = var.lambda_schedule_expression != "" ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_job[0].arn
}
