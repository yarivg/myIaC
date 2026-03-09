terraform {
  backend "s3" {
    bucket = "yariv-tf-state-demo-bucket"
    key    = "demo/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "null_resource" "demo" {}
