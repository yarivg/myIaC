variable "v_null_keyword" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
}

variable "v_padded_null" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
}

variable "v_quoted_null" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
}

variable "v_bare_string" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
}

variable "v_quoted_empty" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
}

variable "v_left_empty" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
}

variable "dns" {
  type = object({
    enabled = bool
  })
  default = null
}

resource "null_resource" "qa" {}

output "o_null_keyword" {
  value = var.v_null_keyword
}

output "o_padded_null" {
  value = var.v_padded_null
}

output "o_quoted_null" {
  value = var.v_quoted_null
}

output "o_bare_string" {
  value = var.v_bare_string
}

output "o_quoted_empty" {
  value = format("[%s]", var.v_quoted_empty)
}

output "o_left_empty" {
  value = var.v_left_empty
}

output "o_dns" {
  value = var.dns == null ? "DNS_IS_NULL" : "DNS_IS_SET"
}
