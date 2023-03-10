# Variables section
# used for variable type declaration
variable "rgname" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = ""
}

variable "network" {
    type = object({
        name=string
        address_space=list(string)
    })
}

variable "subnet" {
    type = object({
        name=string
        address_prefixes=list(string)
    })
}

variable "storage_account_for_boot_diag" {
  type=string
}
variable "storage_container_for_boot_diag" {
  type=string
}





# variable "server_vm_info" {
#   description = "Contain object of vm name and additional disks"
#   type = map(object({    
#     location                  = string
#     size                      = string    
#     azure_subnet_id           = string
#     private_ip_address_allocation =string
#     static_ip                 = string         #only needed if private_ip_address_allocation is set to static
#     admin_username            = string
#     admin_password            = string
#     disk_size_gb              = number
#     caching_type              = string
#     storage_account_type      = string
#     source_image_id           = string
#     enable_automatic_updates  = string
#     patch_mode                = string    
#     custom_data               = string

#     additional_disks = list(object({
#       name                    = string
#       disk_size_gb            = number
#       storage_account_type    = string      
#       create_option           = string
#       caching                 = string
#       lun_number              = number
#     }))
    
#   }))
  
#   default = {}
# }