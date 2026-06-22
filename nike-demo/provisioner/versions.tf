terraform {
  required_version = ">= 1.4.0"
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

# Authenticates via ENV0_API_KEY and ENV0_API_SECRET environment variables,
# injected into this env0 environment as sensitive variables.
provider "env0" {}
