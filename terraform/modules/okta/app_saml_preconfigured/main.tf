resource "okta_app_saml" "this" {
  label              = var.label # "amazon"
  preconfigured_app  = var.preconfigured_app # "amazon_aws_sso"
  status             = var.status # "ACTIVE"
  # When using a preconfigured app, below are attributes that do not seem to be
  # computed, but selected as defaults by provider and are _not_ listed as the
  # results of `(known after apply)`
  saml_version = var.saml_version
  user_name_template = var.user_name_template
  user_name_template_type = var.user_name_template_type
  accessibility_self_service = var.accessibility_self_service
  auto_submit_toolbar  = var.auto_submit_toolbar
  hide_ios = var.hide_ios
  hide_web = var.hide_web
  honor_force_authn = var.honor_force_authn
  skip_groups = var.skip_groups
  skip_users = var.skip_users
}