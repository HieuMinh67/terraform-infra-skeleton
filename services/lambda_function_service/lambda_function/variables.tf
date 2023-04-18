locals {
  lambda_bucket      = "${var.aws_account_id}-${var.aws_region}-aws-lambda"
  lambda_file        = var.s3_object_key != "" ? var.s3_object_key : "${var.project}/${var.bounded_context}/builds/${var.service_name}/${var.build_number}.zip"
  function_full_name = "${var.project}_${var.bounded_context}_${var.service_name}_${var.function_name}"
}

variable "s3_object_key" {}

variable "function_name" {}

variable "project" {}

variable "bounded_context" {}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "file_name" {}

variable "lambda_logs_name" {}

variable "handler" {}

variable "is_in_vpc" {}

variable "query_api_source_arn" {}

variable "mutation_api_source_arn" {}

variable "service_name" {}

variable "aws_account_id" {}

variable "organisation" {}

variable "aws_region" {}

variable "bean_region" {
  default = "oregon"
}

variable "environment" {}

variable "db_host" {}
variable "db_user" {}
variable "db_password" {}
variable "db_name" {}

variable "build_number" {}

variable "target_account" {}
variable "lambda_runtime" {}
variable "lambda_timeout" {}
variable "lambda_schedule_expression" {
  type = string
  default = ""
  description = "default = no cron job"
}
