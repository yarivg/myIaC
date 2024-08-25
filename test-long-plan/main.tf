resource "null_resource" "some_resource" {
  count = 3000
}

// create 3000 vars use the index as a suffix
resource "env0_configuration_variable" "example" {
  count = 3000
  name = "example-${count.index}"
  value = "example"
  environment_id = "8b6ff37d-60aa-4725-a365-21d8d1784948"
}
