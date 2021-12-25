data "http" "request" {
    url = var.url
    request_headers = var.request_headers
}
