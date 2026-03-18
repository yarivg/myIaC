resource "null_resource" "hang" {
  provisioner "local-exec" {
    command = "sleep 99999"
  }
}
