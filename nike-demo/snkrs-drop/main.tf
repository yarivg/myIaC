terraform {
  required_version = ">= 1.4.0"
}

variable "drop_name" {
  type        = string
  description = "Name of the sneaker drop this environment powers"
  default     = "air-max-day"
}

variable "storefront_replicas" {
  type        = number
  description = "Number of storefront worker replicas for the drop"
  default     = 3
}

variable "monthly_cost_usd" {
  type        = number
  description = "Declared estimated monthly cost of this drop (USD). The OPA approval policy gates on this value - over the budget, the deploy needs platform admin approval."
  default     = 10
}

# Simulated SNKRS drop stack (pure null_resource: deploys and destroys instantly,
# with no cloud account). The cost signal comes from var.monthly_cost_usd.
resource "null_resource" "product_catalog" {
  triggers = { drop = var.drop_name }
}

resource "null_resource" "inventory_cache" {
  triggers = { drop = var.drop_name }
}

resource "null_resource" "queue_holding_area" {
  triggers = { drop = var.drop_name }
}

resource "null_resource" "storefront_workers" {
  count    = var.storefront_replicas
  triggers = { drop = var.drop_name, replica = count.index }
}
