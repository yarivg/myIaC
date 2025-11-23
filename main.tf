resource "null_resource" "some_resource" {
}

resource "null_resource" "some_resource2" {
}

variable "json_value" {
  type = object({
    some_array = list(string)
  })

  default = null
}

variable "hcl_value" {
  type = object({
    some_array = list(string)
  })

  default = null
}


variable "json_value2" {
  type = object({
    some_array = list(string)
  })

  default = null
}