locals {
  ipv4_regex = "\\d{1,3}.\\d{1,3}.\\d{1,3}.\\d{1,3}\\/\\d{2}"
  ips        = lookup(jsondecode(module.github_meta_api_ips.response), "pages", [])
  github_pages_ipv4s = [
    for ip in local.ips :
    ip
    if can(regex(local.ipv4_regex, ip))
  ]
  github_pages_ipv6s = [
    for ip in local.ips :
    ip
    if !can(regex(local.ipv4_regex, ip))
  ]
}

module "github_meta_api_ips" {
  source = "./http-api-json"
  url    = "https://api.github.com/meta"
}

module "dns_website_hosting" {
  source = "./dns"
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
