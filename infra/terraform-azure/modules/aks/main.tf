terraform { required_providers { azurerm = { source = "hashicorp/azurerm" version = "~> 3.112" } } }
provider "azurerm" { features {} }

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.name}-aks"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.name}-aks"

  default_node_pool {
    name           = "system"
    vm_size        = var.node_vm_size
    node_count     = var.node_count
    vnet_subnet_id = var.subnet_id
  }

  identity { type = "SystemAssigned" }
  oidc_issuer_enabled      = true
  workload_identity_enabled = true
}

output "kube_config"     { value = azurerm_kubernetes_cluster.aks.kube_config_raw sensitive = true }
output "oidc_issuer_url" { value = azurerm_kubernetes_cluster.aks.oidc_issuer_url }
