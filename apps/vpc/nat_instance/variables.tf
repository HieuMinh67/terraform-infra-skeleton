variable "aws_region" {}
variable "vpc_name" {}
variable "security_group_id" {}
variable "vpc_private_route_table_id" {}
variable "vpc_public_subnet_id" {}
variable "private_ips" {
  type = list(any)
}