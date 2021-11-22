
resource "tfe_oauth_client" "this-github" {
  organization     = var.organisation
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_oauth_token
  service_provider = "github"
}

# resource "tfe_run_trigger" "this" {
#  for_each      = { for ws in var.workspaces : "${var.environment}-${ws.app_type}-${ws.app_category}-${ws.app_name}" => ws }
#  workspace_id  = tfe_workspace.this["${var.environment}-${var.platform}-${each.value.app_type}-${each.value.app_category}-${each.value.app_name}"].id
#  sourceable_id = each.value.depends_on == "" ? data.tfe_workspace.this-tfc.id : tfe_workspace.this["${var.environment}-${var.platform}-${each.value.depends_on}"].id
# }

# resource "tfe_notification_configuration" "this-auto-approver" {
#  for_each         = { for ws in var.workspaces : "this-auto-approver-${var.environment}-${ws.app_type}-${ws.app_category}-${ws.app_name}" => ws }
#  name             = "this-auto-approver-${var.environment}-${var.platform}-${each.value.app_type}-${each.value.app_category}-${each.value.app_name}"
#  enabled          = true
#  destination_type = "generic"
#  triggers         = ["run:needs_attention"]
#  url              = data.terraform_remote_state.aws-lambda-workspace.outputs.base_url
#  token            = var.api_key
#  workspace_id     = tfe_workspace.this["${var.environment}-${var.platform}-${each.value.app_type}-${each.value.app_category}-${each.value.app_name}"].id
# }


# Create a private SSH key for downloading Terraform modules from Git-based module sources
# . This key is not used for cloning the workspace VCS repository or for provisioner connections.
resource "tfe_ssh_key" "this" {
  name         = var.ssh_key_name != "" ? var.ssh_key_name : "${var.environment}-${var.platform}-ssh-key"
  organization = var.organisation
  key          = var.private_key
}
