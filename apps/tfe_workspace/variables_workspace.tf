
variable "workspaces" {
  type = list(object({
    app_type         = string
    app_category     = string
    app_name         = string
    auto_apply       = bool
    trigger_prefixes = list(string)
    depends_on       = string
    execution_mode   = string
    is_vcs_connected = bool
  }))
}

variable "aws-lambda-workspace" {
  default = "terraform-api-aws-lambda"
}


variable "api_key" {
  default = "123456789"
}

variable "environment" {
  default = "dev-sg"
}
