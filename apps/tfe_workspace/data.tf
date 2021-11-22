data "tfe_workspace" "this-tfc" {
  name         = "${var.environment}-${var.platform}-${var.app_type}-${var.app_category}-${var.app_name}"
  organization = var.organisation
}

data "terraform_remote_state" "aws-lambda-workspace" {
  backend = "remote"

  config = {
    organization = var.organisation
    workspaces = {
      name = var.aws-lambda-workspace
    }
  }
}

