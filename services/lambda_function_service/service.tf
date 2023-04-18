# resource "aws_api_gateway_resource" "this-proxy-mutation" {
#   rest_api_id = data.aws_api_gateway_rest_api.mutation-api.id
#   parent_id   = var.mutation_api_parent_id == "" ? local.mutation_api_gateway_root_resource_id : var.mutation_api_parent_id
#   path_part   = local.path_part
# }

# resource "aws_api_gateway_resource" "this-proxy-query" {
#   rest_api_id = data.aws_api_gateway_rest_api.query-api.id
#   parent_id   = var.query_api_parent_id == "" ? local.query_api_gateway_root_resource_id : var.query_api_parent_id
#   path_part   = local.path_part
# }

module "lambda_function" {
  source                  = "./lambda_function"
  build_number            = var.build_number
  query_api_source_arn    = local.query_api_gateway_execution_arn
  mutation_api_source_arn = local.mutation_api_gateway_execution_arn

  service_name     = var.service_name
  function_name    = var.function_name
  file_name        = local.file_name
  lambda_logs_name = var.function_name
  handler          = local.handler
  is_in_vpc        = var.is_in_vpc
  s3_object_key    = var.s3_object_key
  target_account   = var.target_account
  lambda_runtime   = var.lambda_runtime
  lambda_timeout   = var.lambda_timeout
  
  lambda_schedule_expression = var.lambda_schedule_expression
  # subnet_ids         = data.aws_subnet_ids.private.ids
  # security_group_ids = tolist([data.terraform_remote_state.vpc.outputs.vpc_default_security_group_id])

  subnet_ids         = []
  security_group_ids = []
  aws_account_id     = var.aws_account_id
  organisation       = var.organisation
  aws_region         = var.aws_region
  project            = var.project
  bounded_context    = var.bounded_context
  environment        = var.environment
  db_host            = var.db_host
  db_user            = var.db_user
  db_password        = var.db_password
  db_name            = var.db_name
}


module "http_apigateway_integration" {
  count                      = var.is_http_api ? 1 : 0
  source                     = "./http_apigateway_integration"
  lambda_function_invoke_arn = module.lambda_function.invoke_arn # aws_lambda_function.this.invoke_arn
  lambda_function_name       = module.lambda_function.name
  apigateway_execution_arn   = var.apigateway_execution_arn
  apigateway_id              = var.apigateway_id
  apigateway_name            = var.apigateway_name

  service_routes = var.service_routes
  authorizer_id  = var.authorizer_id
}


# module "query-api-gateway-integration" {
#   count                   = var.is_query_api ? 1 : 0
#   source                  = "./api-gateway-integration"
#   rest_api_id             = data.aws_api_gateway_rest_api.query-api.id
#   is_query_api            = true
#   is_mutation_api         = false
#   mutation_methods        = []
#   resource_id             = aws_api_gateway_resource.this-proxy-query.id
#   path_part               = local.path_part
#   is_auth_required        = var.is_auth_required
#   authorization           = var.authorization
#   integration_http_method = var.integration_http_method
#   type                    = var.type
#   # uri                     = aws_lambda_function.exampleservice-test1-query-api.invoke_arn
#   uri          = module.lambda-function.invoke_arn
#   source_arn   = local.query_api_gateway_execution_arn
#   organisation = var.organisation
#   environment  = var.environment
# }

# module "mutation-api-gateway-integration" {
#   count            = var.is_mutation_api ? 1 : 0
#   source           = "./api-gateway-integration"
#   rest_api_id      = data.aws_api_gateway_rest_api.mutation-api.id
#   is_query_api     = false
#   is_mutation_api  = true
#   mutation_methods = var.mutation_methods
#   resource_id      = aws_api_gateway_resource.this-proxy-mutation.id
#   # parent_id               = var.parent_id == "" ? local.api_gateway_root_resource_id : var.parent_id
#   path_part               = local.path_part
#   is_auth_required        = var.is_auth_required
#   authorization           = var.authorization
#   integration_http_method = var.integration_http_method
#   type                    = var.type
#   # uri                     = aws_lambda_function.exampleservice-test1-query-api.invoke_arn
#   uri          = module.lambda-function.invoke_arn
#   source_arn   = local.mutation_api_gateway_execution_arn
#   organisation = var.organisation
#   environment  = var.environment
# }

# output "query_api_gateway_resource_id" {
#   value = aws_api_gateway_resource.this-proxy-query.id
# }

# output "mutation_api_gateway_resource_id" {
#   value = aws_api_gateway_resource.this-proxy-mutation.id
# }
