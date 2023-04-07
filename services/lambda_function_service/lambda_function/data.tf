# data "terraform_remote_state" "efs" {
#   backend = "remote"

#   config = {
#     organization = var.organisation
#     workspaces = {
#       name = "${var.environment}-lambda-${var.app_type}-hvcg-efs"
#     }
#   }
# }

data "aws_s3_bucket_object" "this" {
  bucket = local.lambda_bucket
  key    = local.lambda_file
}

data "aws_iam_role" "iam_for_lambda" {
  name = "${var.environment}_iam_for_lambda"
}

# data "aws_iam_policy" "policy_for_lambda" {
#   name = "${var.environment}_policy_for_lambda"
# }
