terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name}-law"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
}

output "workspace_id" { value = azurerm_log_analytics_workspace.law.workspace_id }
