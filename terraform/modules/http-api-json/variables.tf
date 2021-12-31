variable "url" {
    description = "The HTTP or HTTPS endpoint for JSON responses."
    type = string
    default = "https://httpbin.org/get"
}

variable request_headers {
    description = "One or more key-value pairs, headers to pass with the HTTP or HTTPS request."
    type = map
    default = {}
}