/*
 Inpout Variables
# Azure Location
# Azure Resource Group Name
# Azure AKS envirnoment ( nprod , Prod, etc)
*/

resource "azurerm_resource_group" "aks_rg" {
    name = "${var.resource_group_name}-${var.environment}"
    location = var.location

}
  
