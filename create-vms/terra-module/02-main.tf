resource "azurerm_resource_group" "RG" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_virtual_network" "vNet" {
  name                = var.network.name
  address_space       = var.network.address_space
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_subnet" "sNet" {
  name                 = var.subnet.name
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vNet.name
  address_prefixes     = var.subnet.address_prefixes
}

#--------------------------------------------------------------