locals {
  apigateway_name = var.apigateway_name
}

variable "apigateway_name" {}
variable "bounded_context" {}

variable "is_auth_required" {
  default = true
}

variable "jwt_audience" {}
variable "jwt_issuer" {}

variable "aws_account_id" {
  default = "891616054205"
}

variable "organisation" {
  default = "HocVienCongGiao"
}

variable "aws_region" {
  default = "us-west-2"
}
