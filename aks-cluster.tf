# Provision AKS Cluster
/*
1. Add Basic Cluster Settings
  - Get Latest Kubernetes Version from datasource (kubernetes_version)
  - Add Node Resource Group (node_resource_group)
2. Add Default Node Pool Settings
  - orchestrator_version (latest kubernetes version using datasource)
  - availability_zones
  - enable_auto_scaling
  - max_count, min_count
  - os_disk_size_gb
  - type
  - node_labels
  - tags
3. Enable MSI
4. Add On Profiles 
  - Azure Policy
  - Azure Monitor (Reference Log Analytics Workspace id)
5. RBAC & Azure AD Integration
6. Admin Profiles
  - Windows Admin Profile
  - Linux Profile
7. Network Profile
8. Cluster Tags  
*/


resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${azurerm_resource_group.aks_rg.name}-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${azurerm_resource_group.aks_rg.name}-dnscluster"
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"


  default_node_pool {
    name                    = "systempool"
    orchestrator_version    = data.azurerm_kubernetes_service_versions.current.latest_version
    vm_size                 = "Standard_D2_v2"
    node_public_ip_enabled  = false 
    auto_scaling_enabled    = true
    max_count               = 3
    min_count               = 1 
    os_disk_size_gb         = 30
    type                    = "VirtualMachineScaleSets" 
    node_labels = {
      "nodepool-type"       = "system"
      "envirnoment"         = "nprod"
      "nodepoolos"          = "Linux"

    }
    tags = {
      "nodepool-type"       = "system"
      "envirnoment"         = "nprod"
      "nodepoolos"          = "Linux"

    }

  }
# Pour identite on utilise System Assigned ou Service Principal
  identity {
    type = "SystemAssigned"
  }
# Add On Profiles 

azure_policy_enabled = true
oms_agent {
  log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
}

/* RBAC AND Azure AD Integration Block
azure_active_directory_role_based_access_control {

  azure_rbac_enabled = true
 # admin_group_object_ids = [azurerm_kubernetes_cluster.aks_cluster.id]
 # admin_group_object_ids = [azuread_group.aks_admin.id]

}*/

#windows profile
windows_profile {
admin_username = var.windows_admin_username
admin_password = var.windows_admin_password
}
#Linux profile
/*
linux_profile {
  admin_username = "akslinuxadmin"
  ssh_key {
    key_data = 
  }
}
*/
# Network profile
network_profile {
  network_plugin = "azure"
  load_balancer_sku = "standard"
 
}


  tags = {
    Environment = "nprod"
  }
}