
module "nat" {
  count                      = var.enable_nat_instance ? 1 : 0
  source                     = "./nat_instance"
  private_ips                = [var.nat_instance_private_ip]
  security_group_id          = var.nat_instance_sg_id
  aws_region                 = var.aws_region
  vpc_private_route_table_id = module.vpc.private_route_table_ids[0]
  vpc_public_subnet_id       = module.vpc.public_subnets[0]
  vpc_name                   = var.vpc_name
}