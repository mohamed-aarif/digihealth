terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_api_management" "apim" {
  name                = "${var.name}-apim"
  location            = var.location
  resource_group_name = var.rg_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku
}

output "apim_name" { value = azurerm_api_management.apim.name }
