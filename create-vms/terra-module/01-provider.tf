terraform {
  # The backend its where the state will be saved
  backend "azurerm"{
    resource_group_name ="tf-resources-RG"            # variables can not be used, you have to put this manually here
    storage_account_name="stterraform8323"            # variables can not be used, you have to put this manually here
    container_name      ="tf-devops-azure-state"      # container for the key file (its a historial)
    key                 ="create_vms.tfstate"          # this is a file inside the container state
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Configure the Azure provider
provider "azurerm" {
  subscription_id = "f9ad750b-a951-4a98-b88e-051a2af00faf"
  tenant_id       = "a819b19d-9ece-4f81-92e6-5dde6e73e96d"
  client_id       = "0f9f03c8-bf62-4c93-bee3-102b57b9c0ef"       # Azure Service Principal id
  client_secret   = "gQA8Q~g_NLGo-e_sSTEjKXX444hVI5SIyOhaIcs2"   # Azure Service Principal pass
  features {}
}

