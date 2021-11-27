
module "nat" {
  source                     = "./nat_instance"
  private_ips                = ["10.0.4.10"]
  security_group_id          = var.nat_instance_sg_id
  aws_region                 = var.aws_region
  vpc_private_route_table_id = module.vpc.private_route_table_ids[0]
  vpc_public_subnet_id       = module.vpc.public_subnets[0]
}