variable "zone" {
  description = "The main DNS zone for lookup and updates to DNS records."
  type        = string
  default     = "example.com"
}

variable "records" {
  description = "A list zero, one, or more DNS record updates with the host name, type, TTL, and values."
  type = set(object({
    name   = string
    type   = string
    ttl    = number
    values = list(string)
  }))
  default = []
}
