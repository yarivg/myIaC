variable "some_common_var" {
  default = ""
}

resource "null_resource" "some_resource" {
}

resource "null_resource" "some_resource2" {
}

resource "null_resource" "eng_1280_test" {
}

resource "null_resource" "eng_1280_approval_test" {
}

output "a" {
  value = "a as an output"
}

output "b" {
  value = "b as an output"
}

output "c" {
  value = "c as an output"
}
