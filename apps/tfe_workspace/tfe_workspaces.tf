resource "tfe_workspace" "this" {
  for_each            = { for ws in var.workspaces : "${var.environment}-${var.platform}-${ws.app_type}-${ws.app_category}-${ws.app_name}" => ws }
  name                = "${var.environment}-${var.platform}-${each.value.app_type}-${each.value.app_category}-${each.value.app_name}"
  organization        = var.organisation
  speculative_enabled = true
  queue_all_runs      = each.value.depends_on == "" ? true : false
  ssh_key_id          = data.tfe_workspace.this-tfc.ssh_key_id
  execution_mode      = each.value.execution_mode
  auto_apply          = each.value.auto_apply
  global_remote_state = true
  trigger_prefixes = each.value.is_vcs_connected ? concat(each.value.trigger_prefixes,
    [
      "platforms/${var.platform}/apps/hvcg/tfc/releases"
    ]
  ) : null

  working_directory = each.value.is_vcs_connected ? "platforms/${var.platform}/${each.value.app_type}/${each.value.app_category}/${each.value.app_name}" : null
  dynamic "vcs_repo" {
    for_each = each.value.is_vcs_connected ? [1] : []
    content {
      identifier     = "${var.organisation}/terraform-infra"
      branch         = var.infra_stage
      oauth_token_id = tfe_oauth_client.this-github.oauth_token_id
    }
  }
}


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

