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
  default = "HocVienCongGiao"
}

variable "db_host" {}
variable "db_user" {}
variable "db_password" {}
variable "db_name" {}
