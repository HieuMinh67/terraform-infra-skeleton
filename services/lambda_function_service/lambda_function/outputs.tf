output "invoke_arn" {
  description = "Lambda invoke url"

  value = aws_lambda_function.this.invoke_arn
}

output "name" {
  description = "Lambda invoke url"

  value = local.function_full_name
}
 