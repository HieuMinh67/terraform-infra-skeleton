module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = var.app_name
  cidr                 = var.cidr_block
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnet_cidr_blocks
  public_subnets       = var.public_subnet_cidr_blocks
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = true
  enable_dns_hostnames = true

  default_security_group_tags = {
    "Name" = "${var.app_name}-default-sg"
  }

  # let Kops decide what to tag
  # public_subnet_tags = {
  #   "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  #   "kubernetes.io/role/elb"                      = "1"
  #   "type"                                        = "public"
  # }

  # private_subnet_tags = {
  #   "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  #   "kubernetes.io/role/internal-elb"             = "1"
  #   "type"                                        = "private"
  # }
}

# resource "aws_ram_resource_share" "this" {
#   name                      = var.app_name
#   allow_external_principals = false
# }

# resource "aws_ram_resource_association" "this" {
#   for_each           = toset(concat(module.vpc.private_subnet_arns, module.vpc.public_subnet_arns))
#   resource_arn       = each.value
#   resource_share_arn = aws_ram_resource_share.this.arn
# }
# resource "aws_ram_principal_association" "sinh_vien_lam_web" {
#   principal          = "484883180270"
#   resource_share_arn = aws_ram_resource_share.this.arn
# }


data "aws_availability_zones" "available" {
}

# locals {
#   cluster_name = var.app_category
# }
