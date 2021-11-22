# resource "aws_vpc_endpoint" "dynamodb" {
#   vpc_id          = module.vpc.vpc_id
#   service_name    = "com.amazonaws.ap-southeast-1.dynamodb"
#   route_table_ids = module.vpc.private_route_table_ids
# }
