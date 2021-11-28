data "aws_caller_identity" "peer" {
  provider = var.peer_provider
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "requester" {
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  peer_region   = var.peer_region

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC Peering from ${var.vpc_id} to ${var.peer_vpc_id}"
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = var.peer_provider
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}
