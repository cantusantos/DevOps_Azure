# Variable declaration with value
# Used as FronEnd

rgname    = "temp-RG"
location  = "East US"

network   = {
    name = "temp-vNet"
    address_space = ["10.0.0.0/16"]
}

subnet    ={
    name = "temp-sNet"
    address_prefixes = ["10.0.2.0/24"]
}

server_vm_info = {
    "bywus-app-tst0" = {                                 #VM name  
        location                  = "East US"        
        size                      = "Standard_B1s"
        nic_name                  = "nic-production"
        # azure_subnet_id           ="/subscriptions/f9ad750b-a951-4a98-b88e-051a2af00faf/resourceGroups/temp-RG/providers/Microsoft.Network/virtualNetworks/temp-vNet/subnets/temp-sNet"
        private_ip_address_allocation = "Static"
        static_ip                 = ""
	    admin_username            = "luis10"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        #storage_account_type      = "Standard_LRS"
        managed_disk_type         = "Standard_LRS"        
        # source_image_id           = "/subscriptions/f9ad750b-a951-4a98-b88e-051a2af00faf/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
	    enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = ""

    }
}