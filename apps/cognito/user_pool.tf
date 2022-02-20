resource "aws_cognito_user_pool" "main" {
  name = "${var.environment}${title(var.organisation)}${title(var.auth_name)}UserPool"
  admin_create_user_config {
    allow_admin_create_user_only = true # Set to True if only the administrator is allowed to create user profiles. Set to False if users can sign themselves up via an app.
  }
  password_policy {
    temporary_password_validity_days = 40
    minimum_length                   = 8
    require_lowercase                = true # Whether you have required users to use at least one lowercase letter in their password.
    require_numbers                  = true # Whether you have required users to use at least one number in their password.
    require_symbols                  = true # Whether you have required users to use at least one symbol in their password.
    require_uppercase                = true # Whether you have required users to use at least one upercase letter in their password.
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.app_name # must be in lowercase or ${var.auth_name}.auth.${var.environment}.${var.auth_root_domain}
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_pool_client" "secret-client" {
  name = "secret-client"

  user_pool_id = aws_cognito_user_pool.main.id

  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  generate_secret = true

  allowed_oauth_flows_user_pool_client = true # Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools.

  allowed_oauth_flows = [
    "client_credentials"
  ] # List of allowed OAuth flows (code, implicit, client_credentials). client_credentials flow can not be selected along with code flow or implicit flow.

  supported_identity_providers = [
    "COGNITO"
  ] # A list of provider names for the identity providers that are supported on this client. The following are supported: COGNITO, Facebook, Google and LoginWithAmazon.



  allowed_oauth_scopes = aws_cognito_resource_server.main.scope_identifiers # List of allowed OAuth scopes (phone, email, openid, profile, and aws.cognito.signin.user.admin). Not a single managed scope is not supported with client_credentials flow
}

resource "aws_cognito_user_pool_client" "web-client" {
  name = "web-client"

  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  #     Choose which errors and responses are returned by Cognito APIs during authentication, 
  # account confirmation, and password recovery when the user does not exist in the user pool. 
  #     When set to ENABLED and the user does not exist, authentication returns an error indicating 
  # either the username or password was incorrect, and account confirmation and password recovery return 
  # a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs will 
  # return a UserNotFoundException exception if the user does not exist in the user pool.
  prevent_user_existence_errors = "ENABLED"
}
