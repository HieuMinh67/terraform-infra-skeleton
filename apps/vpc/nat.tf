
module "nat" {
  source = "nat_instance"
  private_ips       = ["10.0.4.10"]
  security_group_id = var.nat_instance_sg_id
  aws_region        = var.aws_region
}