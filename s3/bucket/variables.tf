variable "aws_account_id" {
  type = string
}
variable "aws_region" {
  type = string
  default = "us-west-2"
}
variable "suffix_name" {
  type = string
  default = "aws-lambda"
}
variable "enable_versioning" {
  type = bool
  default = false
}