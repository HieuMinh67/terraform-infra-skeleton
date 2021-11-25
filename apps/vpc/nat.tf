
module "nat" {
  private_ips       = ["10.0.4.10"]
  security_group_id = aws_security_group.allow_all.id
  aws_region        = var.aws_region
}