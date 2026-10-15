module "hub_module" {
  source  = "api-dev.dev.env0.com/63c723d4-5a73-491e-b187-ad4963914c46/repro-1333-private/aws"
  version = "2.0.0"
}

output "proof" {
  value = "hub module resolved from spoke org"
}
