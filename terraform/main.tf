terraform {
  backend "s3" {}
}

locals {
  ipv4_regex = "\\d{1,3}.\\d{1,3}.\\d{1,3}.\\d{1,3}\\/\\d{2}"
  ips        = lookup(jsondecode(module.github_meta_api_ips.response), "pages", [])
  github_pages_ipv4s = sort([
    for ip in local.ips :
    replace(ip, "/32", "")
    # The GitHub API Meta Endpoint returns multiple IP addresses for the Pages service
    # that can be used for an apex domain and required A and AAAA records. See:
    #
    # https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
    #
    # The API endpoint returns 192.30.x.y addresses that point to github.com, not 
    # github.io and lead to TLS cert mistmatch failures. So filter those out as well.
    if can(regex(local.ipv4_regex, ip)) && can(regex("185.*$", ip))
  ])
  github_pages_ipv6s = sort([
    for ip in local.ips :
    replace(ip, "/128", "")
    if !can(regex(local.ipv4_regex, ip))
  ])
}

module "github_meta_api_ips" {
  source = "./modules/http-api-json"
  url    = "https://api.github.com/meta"
}

module "dns_website_hosting" {
  source = "./modules/dns"
  zone   = "oscal.club"
  records = [
    {
      name   = "@"
      type   = "A"
      ttl    = 1800
      values = local.github_pages_ipv4s
    },
    {
      name   = "@"
      type   = "AAAA"
      ttl    = 1800
      values = local.github_pages_ipv6s
    },
    {
      name = "www"
      type = "CNAME"
      ttl  = 1800
      values = [
        "oscal-club.github.io."
      ]
    }
  ]
}

module "aws_organization" {
  source = "./modules/aws/organizations/organization"
}

module "okta_app_saml_aws" {
  source = "./modules/okta/app_saml_preconfigured"
  label              = "amazon"
  preconfigured_app  = "amazon_aws_sso"
  status             = "ACTIVE"
  user_name_template = "$${source.email}"
}

module "okta_group_app_saml_aws_admins" {
  source = "./modules/okta/group"
  name = "saml-aws-oscal-club-admins"
  description = "The Okta group with membership that provides AdministratorAccess privileges to oscal.club accounts via AWS SAML auth."
  skip_users = false
}
