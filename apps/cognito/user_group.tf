# resource "aws_cognito_user_group" "customer" {
#   name         = "CustomerGroup"
#   user_pool_id = aws_cognito_user_pool.main.id
#   description  = "Student Group managed by Terraform"
#   precedence   = 42
# }
# resource "aws_cognito_user_group" "operator" {
#   name         = "OperatorGroup"
#   user_pool_id = aws_cognito_user_pool.main.id
#   description  = "Operator Group managed by Terraform"
#   precedence   = 40
# }
# resource "aws_cognito_user_group" "admin" {
#   name         = "AdminGroup"
#   user_pool_id = aws_cognito_user_pool.main.id
#   description  = "Admin Group managed by Terraform"
#   precedence   = 38
# }
