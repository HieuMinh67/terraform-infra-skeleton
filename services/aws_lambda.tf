resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_lambda_function" "aws-nuke" {
  function_name = "aws-nuke"
  role          = aws_iam_role.iam_for_lambda.arn
  s3_bucket     = "bean-training-build-nuke"
  s3_key        = "aws-nuke.zip"
  handler       = "aws-nuke"
  runtime       = "go1.x"
  package_type  = "Zip"
}

resource "aws_cloudwatch_event_rule" "cron_job" {
  name                = "aws-nuke-cron-job"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda_on_schedule" {
  arn  = aws_lambda_function.aws-nuke.arn
  rule = aws_cloudwatch_event_rule.cron_job.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_split_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws-nuke.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_job.arn
}
