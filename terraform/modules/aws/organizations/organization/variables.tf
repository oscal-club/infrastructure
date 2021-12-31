variable "aws_service_access_principals" {
    description = "List of AWS service principal names for which you want to enable integration with your organization."
    type = list(string)
    default = [
        "cloudtrail.amazonaws.com",
        "config.amazonaws.com"
    ]
}

variable "enabled_policy_types" {
    description = "List of Organizations policy types to enable in the Organization Root."
    type = list(string)
    default = null
}

variable "feature_set" {
    description = ""
    type = string
    default = "ALL"
}