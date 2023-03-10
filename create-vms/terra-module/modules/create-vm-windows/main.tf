#01.first create the storage account for boot diagnostics
/*
resource "azurerm_storage_account" "dev_boot_diag" {
  name                     = "testluis09032021"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags={
        environment="Terraform Storage"
        CreatedBy= "Luis Mendez"
    }
}
resource "azurerm_storage_container" "lab" {
  name                  = "bootblob"
  storage_account_name  = azurerm_storage_account.dev_boot_diag.name
  container_access_type = "private"
}
*/
#this is the one that we want
#"https://testluis09032021.blob.core.windows.net"
/*
output "bloburl" {
  value = azurerm_storage_account.lab.primary_blob_endpoint
}
*/

#02.second we are going to create the network cards for the machines 
resource "azurerm_network_interface" "server_dev_nic" {
  
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.nic_name
    subnet_id                     = var.azure_subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.static_ip
    private_ip_address_version    = "IPv4"
    primary                       = true
  }
  tags                          = var.resource_tags
}

#03.next step, create the vm

resource "azurerm_windows_virtual_machine" "server_db" {
  name                        = var.server_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  size                        = var.size
  network_interface_ids       = [azurerm_network_interface.server_dev_nic.id]
  admin_username              = var.admin_username
  admin_password              = var.admin_password
  tags                        = var.resource_tags

  os_disk {
    name                      = join("-", [lower(var.server_name), "os"])
    caching                   = var.caching_type
    storage_account_type      = var.storage_account_type
    disk_size_gb              = var.disk_size_gb
  }
  source_image_id             = var.source_image_id
  
  enable_automatic_updates    = var.enable_automatic_updates 
  patch_mode                  = var.patch_mode 

  custom_data = base64encode("${file(var.custom_data)}")
    

# Uncomment for PROD 
 boot_diagnostics {  
    storage_account_uri       = var.primary_blob_endpoint
    
 }
}


locals {
  vm_disks = {
    for i in var.additional_disks : i.name => i
  }
}


resource "azurerm_managed_disk" "azure_machine_disks" {
    for_each               = local.vm_disks
    name                   = join("-", [lower(var.server_name), each.value.name])
    location               = var.location
    resource_group_name    = var.resource_group_name
    storage_account_type   = each.value.storage_account_type
    create_option          = each.value.create_option
    disk_size_gb           = each.value.disk_size_gb
    tags                   = var.resource_tags    
}

resource "azurerm_virtual_machine_data_disk_attachment" "azure_disk_attach" {
    for_each               = local.vm_disks
    managed_disk_id        = lookup(azurerm_managed_disk.azure_machine_disks[each.value.name], "id", null)
    virtual_machine_id     = azurerm_windows_virtual_machine.server_db.id
    caching                = each.value.caching
    lun                    = each.value.lun_number    
}


/*we give 5 minutes for breating room */
resource "null_resource" "wait-for-machine-provision" {
  provisioner "local-exec" {
    command = "sleep 300"
  }

  depends_on = [azurerm_virtual_machine_data_disk_attachment.azure_disk_attach]
}


resource "azurerm_virtual_machine_extension" "cloudinit" {
  name                 = azurerm_windows_virtual_machine.server_db.name
  virtual_machine_id    = azurerm_windows_virtual_machine.server_db.id 
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/install.ps1; c:/azuredata/install.ps1 -ForceNewSSLCert\""
    }
    SETTINGS

  depends_on = [null_resource.wait-for-machine-provision]
}

