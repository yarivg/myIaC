resource "null_resource" "some_resource" {
}

resource "null_resource" "some_resource2" {
}

resource "null_resource" "some_resource3" {
  for_each                  = { for i in range(100) : i => i }
}
