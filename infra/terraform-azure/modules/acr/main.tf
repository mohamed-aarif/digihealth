terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_container_registry" "acr" {
  name                = replace("${var.name}acr","-","")
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
}

output "acr_login_server" { value = azurerm_container_registry.acr.login_server }
output "acr_name"         { value = azurerm_container_registry.acr.name }
