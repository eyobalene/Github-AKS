resource "azuread_group" "aks_admin" {

display_name = "${azurerm_resource_group.aks_rg.name}-cluster-admin"
security_enabled = true
  
}

