/*
 Inpout Variables
# Azure Location
# Azure Resource Group Name
# Azure AKS envirnoment ( nprod , Prod, etc)
*/

variable "location" {
    type = string
    default = "canadacentral"
    description = "La location ou toutes les composant sont crees"
  
}

variable "resource_group_name" {
    type = string
    default = "protectiondesdonnes"
    description = "RG d'AKS"
  
}
variable "windows_admin_username" {
    type = string
    default = "aksadmin"
    description = "Les variables pour definir les admins windows"
  
}
variable "windows_admin_password" {
    type = string
    default = "P@ssw0rd123456789"
    description = "Le mot de passe de window admin"
  
}
variable "Linux_admin_username" {
    type = string
    default = "aksadmin"

  
}

variable "environment" {
    type = string
    default = "nprod"
    description = "L'env de Nprod"
}