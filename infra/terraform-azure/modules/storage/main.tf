terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_storage_account" "sa" {
  name                     = replace("${var.name}sa","-","")
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  allow_blob_public_access = false
}

resource "azurerm_storage_container" "records" {
  name                  = "records"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

output "name"                 { value = azurerm_storage_account.sa.name }
output "primary_blob_endpoint"{ value = azurerm_storage_account.sa.primary_blob_endpoint }
