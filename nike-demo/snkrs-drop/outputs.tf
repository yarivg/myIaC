output "drop_name" {
  value = var.drop_name
}

output "storefront_replicas" {
  value = var.storefront_replicas
}

output "instance_type" {
  value = var.instance_type
}

output "region" {
  value = var.region
}

output "storefront_instance_ids" {
  value = aws_instance.storefront[*].id
}
