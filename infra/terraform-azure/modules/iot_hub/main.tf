terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_iothub" "iot" {
  name                = "${var.name}-iothub"
  resource_group_name = var.rg_name
  location            = var.location
  sku { name = "S1" capacity = 1 }
  fallback_route { source = "DeviceMessages" condition = "true" enabled = true endpoint_names = ["events"] }
}

output "iothub_hostname" { value = azurerm_iothub.iot.hostname }
