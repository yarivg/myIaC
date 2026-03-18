data "external" "hang" {
  program = ["bash", "-c", "sleep 99999"]
}
# trigger
