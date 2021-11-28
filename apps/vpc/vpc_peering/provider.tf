provider "aws" {
  alias      = "peer"
  region     = var.peer_aws_region
  access_key = var.peer_aws_access_key_id
  secret_key = var.peer_aws_secret_access_key
}
