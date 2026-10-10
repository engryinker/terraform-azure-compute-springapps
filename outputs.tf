output "spring_cloud_services" {
  description = "Map (same keys as var.spring_cloud_services) of the created azurerm_spring_cloud_service resources."
  value       = azurerm_spring_cloud_service.this
}
