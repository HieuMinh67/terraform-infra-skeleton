resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${local.function_full_name}" # var.lambda_logs_name # Should be the same as function name
  retention_in_days = 14
}
