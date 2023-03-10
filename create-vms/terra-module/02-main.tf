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

#--------------------------------------------------------------------------

module "vm_dev_test_uswest" {
  source                    = "./modules/create-vm-windows"  
  
  for_each                  = var.server_vm_info
  
  server_name               = each.key                                #this is the server name
  location                  = each.value.location
  nic_name                  = "prod-${lower(each.key)}"
  size                      = each.value.size
  azure_subnet_id           = each.value.azure_subnet_id
  private_ip_address_allocation = each.value.private_ip_address_allocation  
  static_ip                 = each.value.static_ip
  admin_username            = each.value.admin_username
  admin_password            = each.value.admin_password  
  caching_type              = each.value.caching_type
  additional_disks          = each.value.additional_disks
  storage_account_type      = each.value.storage_account_type
  disk_size_gb              = each.value.disk_size_gb
  enable_automatic_updates  = each.value.enable_automatic_updates
  patch_mode                = each.value.patch_mode  
  custom_data               = each.value.custom_data 
  resource_tags             = var.resource_tags
  resource_group_location   = resource.azurerm_resource_group.RG.location
  resource_group_name       = resource.azurerm_resource_group.RG.name  
  primary_blob_endpoint     = azurerm_storage_account.dev_boot_diag.primary_blob_endpoint

  depends_on = [azurerm_storage_account.dev_boot_diag]

}


