
output "app_service_url" {
  value = azurerm_app_service.blog_app.default_site_hostname
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}
