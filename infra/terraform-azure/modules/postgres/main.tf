terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = "${var.name}-pg"
  location               = var.location
  resource_group_name    = var.rg_name
  sku_name               = var.sku
  storage_mb             = 32768
  version                = "15"
  delegated_subnet_id    = var.subnet_id
  high_availability { mode = "ZoneRedundant" }
}

resource "azurerm_postgresql_flexible_server_database" "dbs" {
  for_each  = toset(var.databases)
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.pg.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}

output "pg_fqdn" { value = azurerm_postgresql_flexible_server.pg.fqdn }
