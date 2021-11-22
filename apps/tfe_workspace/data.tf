data "tfe_workspace" "this-tfc" {
  name         = "${var.environment}-${var.platform}-terraform-cloud"
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