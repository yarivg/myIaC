terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "drop_name" {
  type        = string
  description = "Name of the sneaker drop this environment powers"
  default     = "air-max-day"
}

variable "region" {
  type        = string
  description = "AWS region for the drop"
  default     = "us-east-1"
}

variable "storefront_replicas" {
  type        = number
  description = "Number of storefront worker instances. Drives the size (and the cost) of the drop - bump this for a global drop."
  default     = 3
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for storefront workers. Bigger = pricier = more likely to need platform approval."
  default     = "m5.large"
}

variable "ami" {
  type        = string
  description = "AMI for the storefront workers. The default is a placeholder used for cost estimation; set a real region-specific AMI for an actual apply."
  default     = "ami-0c02fb55956c7d316"
}

# Provider is configured to plan without real credentials so env0 can run the
# plan + Infracost cost estimation in the demo. A real apply uses the cloud
# credentials env0 injects into the deployment (if the project has any).
provider "aws" {
  region                      = var.region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

# SNKRS storefront worker fleet - the priced, scalable part of the drop.
resource "aws_instance" "storefront" {
  count         = var.storefront_replicas
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.drop_name}-storefront-${count.index}"
    Drop = var.drop_name
    App  = "SNKRS"
  }
}
