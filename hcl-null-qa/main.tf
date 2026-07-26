# ---- HCL-format variables (the fix under test) ----
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
  type    = object({ enabled = bool })
  default = null
}

# ---- non-HCL (plain string) variables ----
variable "s_null_text" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
}
variable "s_empty_text" {
  type    = string
  default = "FELL_BACK_TO_DEFAULT"
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
    s_null_text    = var.s_null_text
    s_empty_text   = var.s_empty_text
  } : k => v == null ? "IS_REAL_NULL" : "IS_STRING<${v}>" }
}

output "r_v_null_keyword" { value = local.describe.v_null_keyword }
output "r_v_padded_null" { value = local.describe.v_padded_null }
output "r_v_quoted_null" { value = local.describe.v_quoted_null }
output "r_v_bare_string" { value = local.describe.v_bare_string }
output "r_v_quoted_empty" { value = local.describe.v_quoted_empty }
output "r_v_left_empty" { value = local.describe.v_left_empty }
output "r_dns" { value = var.dns == null ? "IS_REAL_NULL" : "DNS_IS_SET" }
output "r_s_null_text" { value = local.describe.s_null_text }
output "r_s_empty_text" { value = local.describe.s_empty_text }
