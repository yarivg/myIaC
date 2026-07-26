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

locals {
  describe = { for k, v in {
    v_null_keyword = var.v_null_keyword
    v_padded_null  = var.v_padded_null
    v_quoted_null  = var.v_quoted_null
    v_bare_string  = var.v_bare_string
    v_quoted_empty = var.v_quoted_empty
    v_left_empty   = var.v_left_empty
  } : k => v == null ? "IS_REAL_NULL" : "IS_STRING<${v}>" }
}

output "o_null_keyword" {
  value = local.describe.v_null_keyword
}

output "o_padded_null" {
  value = local.describe.v_padded_null
}

output "o_quoted_null" {
  value = local.describe.v_quoted_null
}

output "o_bare_string" {
  value = local.describe.v_bare_string
}

output "o_quoted_empty" {
  value = local.describe.v_quoted_empty
}

output "o_left_empty" {
  value = local.describe.v_left_empty
}

output "o_dns" {
  value = var.dns == null ? "DNS_IS_NULL" : "DNS_IS_SET"
}
