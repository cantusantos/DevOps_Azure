provider "azurerm" {
  features {}
  use_oidc = true
}

# Creating the ResourceGroup "temp-auto-RG" , the name its get from variables.tf file
resource "azurerm_resource_group" "oidc" {
  name     = var.resource_group_name
  location = var.location
}