# Requestor's side of the connection.
resource "aws_vpc_peering_connection" "requestor" {
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC Peering from ${var.vpc_id} to ${var.peer_vpc_id}"
    Side = "Requestor"
  }
}

# Acceptor's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
  auto_accept               = true

  tags = {
    Side = "Acceptor"
  }
}
