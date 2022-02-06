module "app" {
  source = "git::ssh://git@github.com/BeanCloudServices/terraform-aws-github-app.git?ref=master"

  aws_region = var.aws_region
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  environment = var.environment

  github_app = {
    key_base64     = var.github_app_key_base64
    id             = var.github_app_id
    webhook_secret = var.github_app_webhook_secret
  }

  runner_extra_labels         = var.runner_extra_labels
  lambda_s3_bucket            = var.lambda_s3_bucket
  webhook_lambda_s3_key       = var.webhook_lambda_s3_key
  syncer_lambda_s3_key        = var.syncer_lambda_s3_key
  runners_lambda_s3_key       = var.runners_lambda_s3_key
  enable_organization_runners = true

  # configure your pre-built AMI
  # enabled_userdata = var.enabled_userdata
  # ami_filter       = { name = [var.ami_filter_by_name] }
  # ami_owners       = [var.ami_owner_id]

  # enable access to the runners via SSM
  enable_ssm_on_runners = var.enable_ssm_on_runners

  # override delay of events in seconds
  delay_webhook_event = var.delay_webhook_event

  # override scaling down
  scale_down_schedule_expression = "cron(* * * * ? *)"

  create_service_linked_role_spot = var.create_service_linked_role_spot

}
