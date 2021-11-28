variable "vpc_name" {}
variable "bounded_context" {}
variable "enable_nat_gateway" {
  default = false
}

variable "aws_region" {}

variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "nat_instance_sg_id" {}

variable "nat_instance_private_ip" {
  default = "10.0.4.10"
}

variable "vpc_peerings" {
  type = list(object({
    peer_vpc_id   = string
    vpc_id        = string
    peer_provider = string
    peer_region   = string
  }))
  default = []
}