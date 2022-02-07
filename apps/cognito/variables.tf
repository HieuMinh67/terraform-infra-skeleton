variable "bounded_context" {}

variable "app_type" {}
variable "app_category" {}
variable "app_name" {}
variable "platform" {}
variable "environment" {}
variable "organisation" {}
variable "auth_root_domain" {}
variable "auth_name" {}

locals {
  app_name = "${var.environment}-${var.platform}-${var.app_type}-${var.app_category}-${var.app_name}"
}