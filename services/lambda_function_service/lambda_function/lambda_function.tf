resource "aws_lambda_function" "this" {
  s3_bucket = local.lambda_bucket
  s3_key    = local.lambda_file

  function_name = local.function_full_name
  role          = data.aws_iam_role.iam_for_lambda.arn
  handler       = var.handler
  timeout       = 12

  dynamic "vpc_config" {
    for_each = var.is_in_vpc ? [1] : []
    content {
      # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }

  # dynamic "file_system_config" {
  #   for_each = var.is_in_vpc ? [1] : []
  #   content {
  #     # EFS file system access point ARN
  #     arn = data.terraform_remote_state.efs.outputs.efs_main_access_point_arn

  #     # Local mount path inside the lambda function. Must start with '/mnt/'.
  #     local_mount_path = "/mnt/shared"
  #   }
  # }

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = base64sha256(data.aws_s3_bucket_object.this.last_modified)
  runtime          = var.runtime

  environment {
    variables = {
      # API_KEY   = var.api_key
      # TFE_TOKEN = var.tfe_token
      LAMBDA_FUNCTION_NAME = var.function_name
      APP_DB_HOST          = var.db_host
      APP_DB_USER          = var.db_user
      APP_DB_PASSWORD      = var.db_password
      APP_DB_NAME          = var.db_name
      APP_ENV              = var.environment
      DEFAULT_JWT_STRING   = "eyJraWQiOiJaTGpneG41SStaZEpldnJRb0lpMTZEWEZoRHI4eG9UbVZ2b2ZuVm5vb3RFPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJmZDlhN2FmOC1mYTc2LTRiODYtYWYzZC1kOTYzNGVmNTIzNzQiLCJhdWQiOiIxcmF2NDExbmNjbnA3M2h0b3BiaG1sOHM2MSIsImNvZ25pdG86Z3JvdXBzIjpbIk9wZXJhdG9yR3JvdXAiXSwiZXZlbnRfaWQiOiI5NjQ1ZDYyMi0zZjRiLTQyYjctOWI0ZC03MWQzNWRhOTI1NmQiLCJ0b2tlbl91c2UiOiJpZCIsImF1dGhfdGltZSI6MTYyMzkzNDkyNiwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb21cL2FwLXNvdXRoZWFzdC0xXzlRV1NZR3pYayIsInBob25lX251bWJlcl92ZXJpZmllZCI6dHJ1ZSwiY29nbml0bzp1c2VybmFtZSI6ImRldi1vcGVyYXRvciIsInBob25lX251bWJlciI6Iis4NDM2OTE0MDkxNiIsImV4cCI6MTYyMzk0ODAwOCwiaWF0IjoxNjIzOTQ0NDA4fQ.ml3N8J7uw4rbQOneEdnmQW6OwsAY6ycmp5PIrKGZKF3yWQn0oQECIhF2Q_jjWOjWPikpUQEy5IKgghiJLukgKo7q-T4tUauPG3GJxoSGQkfVcglkNu8nZTu7ioxXzlQAWsXLakgkH40mGzI6kl2hkEhRQh_lWGrT7TqDP2yVTsDMKEGJBdtcb-kFCnYHfn9FMoCyVGo4K3tSrkeGno7bzwO_XpFtZRhv9Qs4OtfESXARYCP3St69hyf4JuAop6-Zb38FPWcp6rnpRG3BF64YPGqo0J0MAyWVz_Du7Pk3-H5uZqqrr6iHKoPwoabPPlZxJ3JGdifVt_I54SwTbelbzw"
    }
  }

  # Explicitly declare dependency on EFS mount target.
  # When creating or updating Lambda functions, mount target must be in 'available' lifecycle state.
  depends_on = [
    # aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.this
  ]

  tags = {
    BoundedContext = var.bounded_context
    Project        = var.project
    ServiceName    = var.service_name
  }

}
