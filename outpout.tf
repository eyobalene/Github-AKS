# Resource Group location
# RG ID
# RG name

output "location" {
  
  value = azurerm_resource_group.aks_rg.location
}

output "resouce_group_id" {
    value = azurerm_resource_group.aks_rg.id
  
}
output "resource_group_name" {
    value = azurerm_resource_group.aks_rg.name
}

# Azure AKS DataSource related Output
output "versions" {
  value = data.azurerm_kubernetes_service_versions.current.versions
}

output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}

output "aks_ad_group" {
  value = azuread_group.aks_admin.id
  
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
  
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
  
}

output "aks_cluster_version" {
  value = azurerm_kubernetes_cluster.aks_cluster.kubernetes_version
  
}