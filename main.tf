resource "null_resource" "some_resource" {
}

resource "null_resource" "some_resource2" {
}

resource "null_resource" "qa_pr20793" {
}

resource "null_resource" "qa_pr20793_v2" {
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
