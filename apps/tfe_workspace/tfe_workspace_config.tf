resource "tfe_workspace" "this" {
  for_each            = { for ws in var.workspaces : "${var.environment}-${var.platform}-${ws.app_type}-${ws.app_category}-${ws.app_name}" => ws }
  name                = "${var.environment}-${var.platform}-${each.value.app_type}-${each.value.app_category}-${each.value.app_name}"
  organization        = var.organisation
  speculative_enabled = true
  queue_all_runs      = each.value.depends_on == "" ? true : false
  ssh_key_id          = tfe_ssh_key.this.id
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
