# Variable declaration with value
# Used as FronEnd

rgname    = "create-vms-RG"
location  = "East US"
network   = {
    name = "create-vms-vNet"
    address_space = ["10.0.0.0/16"]
}
subnet    ={
    name = "temp-sNet"
    address_prefixes = ["10.0.3.0/24"]
}

storage_account_for_boot_diag   ="bootdiag0392023"
storage_container_for_boot_diag ="bootblob"

#in order to get the azure_subnet_id use this command
#az network vnet subnet list --resource-group create-vms-RG --vnet-name create-vms-vNet
server_vm_info = {
    "bywus-app-tst0" = {        
        location                  = "East US"        
        size                      = "Standard_B1s"        
        azure_subnet_id           ="/subscriptions/f9ad750b-a951-4a98-b88e-051a2af00faf/resourceGroups/create-vms-RG/providers/Microsoft.Network/virtualNetworks/create-vms-vNet/subnets/temp-sNet"
        private_ip_address_allocation = "Static"
        static_ip                 = "10.0.3.5"
        admin_username            = "osvaldo"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        storage_account_type      = "Standard_LRS"                
        enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = "./files/bywus-app-tst0.ps1"

        additional_disks = [{
            name                    ="drivef"
            disk_size_gb            = 50
            storage_account_type    = "Premium_LRS"
            create_option           = "Empty"
            caching                 = "ReadWrite"
            lun_number              = 10            
        }, ]       
    },
}


resource_tags                   = {
    core-app-name   = "my app"
    core-app-owner  = "osvaldo@gmail.com"
    core-env        = "tst"            
    CostCenter      = "1236"
    code-number     = "123456"
}
