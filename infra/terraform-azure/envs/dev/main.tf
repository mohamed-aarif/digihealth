########################################
# Root (envs/dev) – Modules Wiring
########################################

# Networking (creates RG/VNet/Subnet)
module "network" {
  source            = "../../modules/network"
  name              = var.name
  rg_name           = var.rg_name
  location          = var.location
  address_space     = var.address_space
  aks_subnet_prefix = var.aks_subnet_prefix
}

# Azure Container Registry
module "acr" {
  source   = "../../modules/acr"
  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

# AKS (placeholder unless you add resources in the module)
module "aks" {
  source       = "../../modules/aks"
  name         = var.name
  location     = module.network.location
  rg_name      = module.network.rg_name
  subnet_id    = module.network.subnet_aks_id
  node_count   = var.aks_node_count
  node_vm_size = var.aks_node_vm_size
}

# API Management
module "apim" {
  source          = "../../modules/apim"
  name            = var.name
  location        = module.network.location
  rg_name         = module.network.rg_name
  publisher_name  = var.apim_publisher_name
  publisher_email = var.apim_publisher_email
  sku             = var.apim_sku
}

# Event Hubs
module "event_hubs" {
  source   = "../../modules/event_hubs"
  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

# IoT Hub
module "iot_hub" {
  source   = "../../modules/iot_hub"
  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

# Key Vault
module "keyvault" {
  source   = "../../modules/keyvault"
  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

# Monitor / Log Analytics
module "monitor" {
  source   = "../../modules/monitor"
  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

# PostgreSQL (Flexible Server)
module "postgres" {
  source   = "../../modules/postgres"
  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
  sku      = var.postgres_sku
}

# Storage
module "storage" {
  source   = "../../modules/storage"
  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}