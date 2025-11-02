########################################
# Root (envs/dev) – Modules Wiring
# (versions.tf and providers.tf stay separate)
########################################

############################
# Networking (create RG/VNet/Subnet)
############################
module "network" {
<<<<<<< HEAD
  source   = "../../modules/network"
  name     = "digihealth-dev"
  rg_name  = "rg-digihealth-dev"
  location = "eastus"
=======
  source = "../../modules/network"

  name              = var.name
  rg_name           = var.rg_name
  location          = var.location
  address_space     = var.address_space
  aks_subnet_prefix = var.aks_subnet_prefix
>>>>>>> d6b14bb (updated files for pipeline)
}

############################
# Azure Container Registry
############################
module "acr" {
  source = "../../modules/acr"

  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

############################
# AKS
############################
module "aks" {
  source = "../../modules/aks"

  name      = var.name
  location  = module.network.location
  rg_name   = module.network.rg_name
  subnet_id = module.network.subnet_aks_id

  node_count   = var.aks_node_count
  node_vm_size = var.aks_node_vm_size
}

############################
# API Management
############################
module "apim" {
  source = "../../modules/apim"

  name            = var.name
  location        = module.network.location
  rg_name         = module.network.rg_name
  publisher_name  = var.apim_publisher_name
  publisher_email = var.apim_publisher_email
  sku             = var.apim_sku
}

############################
# Event Hubs
############################
module "event_hubs" {
  source = "../../modules/event_hubs"

  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

############################
# IoT Hub
############################
module "iot_hub" {
  source = "../../modules/iot_hub"

  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

############################
# Key Vault
############################
module "keyvault" {
  source = "../../modules/keyvault"

  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

############################
# Monitor / Log Analytics
############################
module "monitor" {
  source = "../../modules/monitor"

  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

<<<<<<< HEAD
output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "apim_name" {
  value = module.apim.apim_name
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "pg_fqdn" {
  value = module.postgres.pg_fqdn
}

output "blob_endpoint" {
  value = module.storage.primary_blob_endpoint
}

output "key_vault_uri" {
  value = module.keyvault.key_vault_uri
}

output "iothub_hostname" {
  value = module.iot.iothub_hostname
}

output "event_hubs_broker" {
  value = module.event_hubs.kafka_broker
}

output "log_workspace_id" {
  value = module.monitor.workspace_id
}
=======
############################
# PostgreSQL (Flexible Server)
############################
module "postgres" {
  source = "../../modules/postgres"

  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
  sku      = var.postgres_sku
}

############################
# Storage
############################
module "storage" {
  source = "../../modules/storage"

  name     = var.name
  rg_name  = module.network.rg_name
  location = module.network.location
}

############################
# Outputs
############################
output "rg_name" {
  value = module.network.rg_name
}

output "location" {
  value = module.network.location
}

output "acr_name" {
  value = try(module.acr.acr_name, null)
}

output "acr_login_server" {
  value = try(module.acr.acr_login_server, null)
}

# Keep only if your AKS module actually exports these.
output "kube_config" {
  value     = try(module.aks.kube_config, null)
  sensitive = true
}

output "kube_config_raw" {
  value     = try(module.aks.kube_config_raw, null)
  sensitive = true
}
>>>>>>> d6b14bb (updated files for pipeline)
