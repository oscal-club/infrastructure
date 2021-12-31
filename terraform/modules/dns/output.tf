output "zone" {
  value = try(data.gandi_domain.zone, "")
}

output "records" {
  value = try(gandi_livedns_record.records, [])
}