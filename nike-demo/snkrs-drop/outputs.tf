output "drop_name" {
  value = var.drop_name
}

output "storefront_replicas" {
  value = var.storefront_replicas
}

output "monthly_cost_usd" {
  value = var.monthly_cost_usd
}

output "storefront_endpoint" {
  value = "https://${var.drop_name}.snkrs.nike.demo"
}
