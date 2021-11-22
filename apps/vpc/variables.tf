variable "app_name" {}
variable "bounded_context" {}
variable "enable_nat_gateway" {
  default = false
}

variable "cidr_block" {
    default = "10.0.0.0/16"
}
variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
variable "private_subnet_cidr_blocks" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "aws_region" {}
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
