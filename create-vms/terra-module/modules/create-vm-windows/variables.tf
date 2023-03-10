variable "server_name" {
  type = string
}
variable "location" {
  type = string
}

variable "nic_name" {
  type = string
}
variable "size" {
  type = string
}
variable "azure_subnet_id" {
  type = string
}
variable "private_ip_address_allocation" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type = string
}
variable "disk_size_gb" {
  type =string
}
variable "caching_type" {
  type = string
}
variable "storage_account_type" {
  type = string
}
variable "enable_automatic_updates" {
  type = string
}
variable "patch_mode" {
  type = string
}

variable "primary_blob_endpoint" {
  type = string
}



  
#################################################
 variable "additional_disks" {
  type = list(object({
      name                    = string
      disk_size_gb            = number
      storage_account_type    = string
      create_option           = string 
      caching                 = string     
      lun_number              = number 
  }))
  default =[]
 }

#############################################    
variable "resource_tags" {
  description = "Map value containing the resource tags."
  type = map
}

variable "resource_group_location" {
  type=string
}

variable "resource_group_name" {
  type=string
}

variable "custom_data" {
  type=string
}

variable "static_ip" {
  type=string
}