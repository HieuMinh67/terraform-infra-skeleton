locals {
  handler                               = var.handler != "" ? var.handler : var.function_name
  path_part                             = var.path_part != "" ? var.path_part : var.function_name
  file_name                             = var.file_name != "" ? var.file_name : var.function_name
  query_api_gateway_root_resource_id    = "" # data.aws_api_gateway_rest_api.query-api.root_resource_id
  mutation_api_gateway_root_resource_id = "" # data.aws_api_gateway_rest_api.mutation-api.root_resource_id
  query_api_gateway_execution_arn       = "" #${data.aws_api_gateway_rest_api.query-api.execution_arn}/*/*"
  mutation_api_gateway_execution_arn    = "" # ${data.aws_api_gateway_rest_api.mutation-api.execution_arn}/*/*"
}

variable "service_routes" {
  type = list(object({
    method = string
    path   = string
  }))
}

variable "apigateway_execution_arn" {} # aws_apigatewayv2_api.example.execution_arn
variable "apigateway_id" {}            #  aws_apigatewayv2_api.example.id
variable "apigateway_name" {}

variable "project" {}

variable "bounded_context" {}

variable "s3_object_key" {
  type        = string
  description = "Key used for building lambda function"
  default     = ""
}

variable "path_part" {
  default = ""
}

variable "file_name" {
  default = ""
}

variable "function_name" {
  default = "root"
}

variable "handler" {
  default = ""
}

variable "is_in_vpc" {
  default = false
}

variable "is_auth_required" {
  default = false
}

variable "authorizer_id" {
  nullable = true
}

variable "is_http_api" {
  default = true
}

variable "is_mutation_api" {
  default = true
}

variable "service_name" {}

variable "aws_account_id" {
  default = "891616054205"
}

variable "organisation" {
  default = "HocVienCongGiao"
}
variable "aws_region" {
  default = "us-west-2"
}

variable "mutation_api_parent_id" {
  default = ""
}

variable "query_api_parent_id" {
  default = ""
}

variable "mutation_methods" {
  default = [
    "POST",
    "PUT",
    "DELETE",
    "PATCH"
  ]
}

variable "authorization" {
  default = "COGNITO_USER_POOLS"
}

variable "integration_http_method" {
  default = "POST"
}

variable "type" {
  default = "AWS_PROXY"
}

variable "environment" {}

variable "db_host" {
  default = ""
}
variable "db_user" {
  default = ""
}
variable "db_password" {
  default = ""
}
variable "db_name" {
  default = ""
}

variable "build_number" {
  default = "latest"
}

variable "target_account" {
  type = map(string)
}

variable "lambda_runtime" {
  type = string
  default = "provided.al2"
}

variable "lambda_timeout" {
  type = number
  default = 12
}


variable "lambda_schedule_expression" {
  type = string
  default = ""
  description = "default = no cron job"
}
