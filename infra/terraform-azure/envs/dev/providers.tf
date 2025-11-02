terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.112"
    }
  }

  backend "azurerm" {
    resource_group_name  = "RG-DIGIHEALTH"
    storage_account_name = "terraformdigicodeops"   # change
    container_name       = "terraformcontainer"
    key                  = "dev.tfstate"
    # When using access key from env (ARM_ACCESS_KEY), do not set use_azuread_auth
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
}