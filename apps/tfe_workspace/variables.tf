locals {
  shared_environment_variables = {
  }
  shared_terraform_variables = {
    environment    = var.environment,
    platform       = var.platform,
    aws_region     = var.aws_region,
    aws_account_id = var.aws_account_id
  }
}

variable "private_key" {}
variable "platform" {}
variable "app_type" {}
variable "app_category" {
  default = "tfc"
}
variable "app_name" {
  default = "workspace"
}

variable "infra_stage" {}
variable "aws_region" {
  default = "ap-southeast-1"
}

variable "aws_account_id" {}
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

variable "tfe_token" {}

variable "github_oauth_token" {}
variable "organisation" {
  default = "BeanTraining"
}
