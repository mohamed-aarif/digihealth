terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }


resource "azurerm_resource_group" "rg" {
name = var.rg_name
location = var.location
}


resource "azurerm_virtual_network" "vnet" {
name = "${var.name}-vnet"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
address_space = var.address_space
}


resource "azurerm_subnet" "aks" {
name = "aks-subnet"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = [var.subnet_aks]
}


resource "azurerm_subnet" "data" {
name = "data-subnet"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = [var.subnet_data]
}


output "rg_name" { value = azurerm_resource_group.rg.name }
output "vnet_id" { value = azurerm_virtual_network.vnet.id }
output "subnet_aks_id" { value = azurerm_subnet.aks.id }
output "subnet_data_id" { value = azurerm_subnet.data.id }