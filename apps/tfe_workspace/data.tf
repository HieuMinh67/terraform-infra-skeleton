data "tfe_workspace" "this_tfc" {
  name         = "${var.environment}-${var.platform}-${var.app_type}-${var.app_category}-${var.app_name}"
  organization = var.organisation
}

# Only enable when we want to enable tfe_run_trigger in tfe_workspaces.tf which is highly unlikely
# data "terraform_remote_state" "aws-lambda-workspace" {
#   backend = "remote"

#   config = {
#     organization = var.organisation
#     workspaces = {
#       name = var.aws-lambda-workspace
#     }
#   }
# }

