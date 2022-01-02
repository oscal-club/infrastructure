variable "label" {}

variable "preconfigured_app" {}

variable "status" {}

variable "saml_version" {
    description = "The default SAML version in use for the Okta SAML app, 1.0, 1.1, or 2.0"
    type = string
    default = "2.0"
}

variable "user_name_template" {}

variable "user_name_template_type" {
    description = "The type of user-name template, one of 'NONE', 'CUSTOM', 'BUILT_IN', got 'BUILT-IN'."
    type = string
    default = "BUILT_IN"
}

variable "accessibility_self_service" {
    default = false
}

variable "auto_submit_toolbar" {
    default = false
}

variable "hide_ios" {
    default = false
}

variable "hide_web" {
    default = false
}

variable "honor_force_authn" {
    default = false
}

variable "skip_groups" {
    default = false
}

variable "skip_users" {
    default = false
}
