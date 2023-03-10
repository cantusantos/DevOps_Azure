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

#01.first create the storage account for boot diagnostics
resource "azurerm_storage_account" "dev_boot_diag" {
  name                     = var.storage_account_for_boot_diag
  resource_group_name      = resource.azurerm_resource_group.RG.name
  location                 = resource.azurerm_resource_group.RG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags={
        environment="Terraform Storage"
        CreatedBy= "Osvaldo Cantu"
    }
}

resource "azurerm_storage_container" "lab" {
  name                  = var.storage_container_for_boot_diag
  storage_account_name  = resource.azurerm_storage_account.dev_boot_diag.name
  container_access_type = "private"
}



