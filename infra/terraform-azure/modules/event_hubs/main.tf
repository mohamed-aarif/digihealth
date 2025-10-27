terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_eventhub_namespace" "eh" {
  name                = "${var.name}-ehns"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  kafka_enabled       = true
}

resource "azurerm_eventhub" "topics" {
  for_each            = toset(["record.added","ai.summary.requested","ai.summary.ready","vitals.ingested","consent.granted","visit.created"])
  name                = each.key
  namespace_name      = azurerm_eventhub_namespace.eh.name
  resource_group_name = var.rg_name
  partition_count     = 4
  message_retention   = 7
}

output "kafka_broker" { value = azurerm_eventhub_namespace.eh.kafka_endpoint }
output "namespace_name" { value = azurerm_eventhub_namespace.eh.name }
