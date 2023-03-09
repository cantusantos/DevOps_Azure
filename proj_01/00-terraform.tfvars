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
        # azure_subnet_id           ="/subscriptions/3258efe1-d8e7-4e11-aa41-7ece0bcd7d88/resourceGroups/rg-west-ETS_NETWORK/providers/Microsoft.Network/virtualNetworks/vnet-west-MMS-SharedServices/subnets/MMS-Development"
        private_ip_address_allocation = "Static"
        static_ip                 = ""
	    admin_username            = "luis10"
        admin_password            = "Passw0rd12345!"        
        disk_size_gb              = 127
        caching_type              = "ReadWrite"
        #storage_account_type      = "Standard_LRS"
        managed_disk_type         = "Standard_LRS"        
        # source_image_id           = "/subscriptions/bf8f2b46-7581-485d-a21e-9ecfc670b79e/resourceGroups/rg-Core-SIG/providers/Microsoft.Compute/galleries/CoreSigProd/images/Windows-2019-CIS/versions/2021.09.15"
	    enable_automatic_updates  = "false"
        patch_mode                = "Manual"        
        custom_data               = ""

        # additional_disks = [{
        #     name                    ="drivef"
        #     disk_size_gb            = 100
        #     storage_account_type    = "Premium_LRS"
        #     create_option           = "Empty"
        #     caching                 = "ReadWrite"
        #     lun_number              = 10            
        # }, ]
    }
}