variable "bounded_context" {}
variable "lambda_s3_bucket" {}
variable "webhook_lambda_s3_key" {}
variable "syncer_lambda_s3_key" {}
variable "runners_lambda_s3_key" {}

variable "github_app_key_base64" {}
variable "github_app_id" {}
variable "github_app_webhook_secret" {}

variable "aws_region" {}
variable "vpc_id" {}
variable "subnet_ids" {}
variable "environment" {}

variable "ami_filter_by_name" {}
variable "ami_owner_id" {}

variable "runner_extra_labels" {
  default = ""
}

variable "create_service_linked_role_spot" {
  default = true
}

variable "enable_ssm_on_runners" {
  default = true
}

variable "delay_webhook_event" {
  default = 5
}

variable "enabled_userdata" {
  default = false
}