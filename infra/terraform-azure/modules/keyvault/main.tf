terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_key_vault" "kv" {
  name                       = "${var.name}-kv"
  location                   = var.location
  resource_group_name        = var.rg_name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 90
}

output "key_vault_uri" { value = azurerm_key_vault.kv.vault_uri }
