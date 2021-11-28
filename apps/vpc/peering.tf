module "peering" {
  count         = length(var.vpc_peerings)
  source        = "./vpc_peering"
  peer_vpc_id   = var.vpc_peerings[count.index].peer_vpc_id
  vpc_id        = var.vpc_peerings[count.index].vpc_id
  peer_provider = var.vpc_peerings[count.index].peer_provider
  peer_region   = var.vpc_peerings[count.index].peer_region
}