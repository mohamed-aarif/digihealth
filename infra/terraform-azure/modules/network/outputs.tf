output "location" {
  value = azurerm_resource_group.rg.location
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "subnet_aks_id" {
  value = azurerm_subnet.aks.id
}
