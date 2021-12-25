terraform {
  required_providers {
    gandi = {
      version = "2.0.0-rc3"
      source  = "github/go-gandi/gandi"
    }
  }
}

# It is expected you pass the credentials outside the module, or by use of the
# GANDI_KEY and GANDI_STAGING_ID
provider "gandi" {}

data "gandi_domain" "zone" {
  name = var.zone
}

resource "gandi_livedns_record" "records" {
  for_each = { for r in var.records : "${r.type}:${r.name}" => r }
  zone     = try(each.value.zone_id, false) ? each.value.zone_id : data.gandi_domain.zone.id
  name     = each.value.name
  type     = each.value.type
  values   = each.value.values
  ttl      = each.value.ttl
}
