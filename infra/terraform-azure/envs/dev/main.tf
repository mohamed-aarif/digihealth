module "network" {
  source       = "../../modules/network"
  name         = "digihealth-dev"
  rg_name      = "rg-digihealth-dev"
  location     = "eastus"
}

module "aks" {
  source     = "../../modules/aks"
  name       = "digihealth-dev"
  location   = module.network.location
  rg_name    = module.network.rg_name
  subnet_id  = module.network.subnet_aks_id
  node_count = 3
}

module "apim" {
  source          = "../../modules/apim"
  name            = "digihealth-dev"
  location        = module.network.location
  rg_name         = module.network.rg_name
  publisher_name  = "DigiHealth"
  publisher_email = "ops@digi.health"
  sku             = "Developer"
}

module "acr" {
  source   = "../../modules/acr"
  name     = "digihealthdev"
  location = module.network.location
  rg_name  = module.network.rg_name
}

module "postgres" {
  source    = "../../modules/postgres"
  name      = "digihealth-dev"
  location  = module.network.location
  rg_name   = module.network.rg_name
  subnet_id = module.network.subnet_data_id
}

module "storage" {
  source   = "../../modules/storage"
  name     = "digihealthdev"
  location = module.network.location
  rg_name  = module.network.rg_name
}

module "keyvault" {
  source    = "../../modules/keyvault"
  name      = "digihealth-dev"
  location  = module.network.location
  rg_name   = module.network.rg_name
  tenant_id = var.tenant_id
}

module "iot" {
  source   = "../../modules/iot_hub"
  name     = "digihealth-dev"
  location = module.network.location
  rg_name  = module.network.rg_name
}

module "event_hubs" {
  source   = "../../modules/event_hubs"
  name     = "digihealth-dev"
  location = module.network.location
  rg_name  = module.network.rg_name
}

module "monitor" {
  source   = "../../modules/monitor"
  name     = "digihealth-dev"
  location = module.network.location
  rg_name  = module.network.rg_name
}

output "kube_config"         { value = module.aks.kube_config sensitive = true }
output "apim_name"           { value = module.apim.apim_name }
output "acr_login_server"    { value = module.acr.acr_login_server }
output "pg_fqdn"             { value = module.postgres.pg_fqdn }
output "blob_endpoint"       { value = module.storage.primary_blob_endpoint }
output "key_vault_uri"       { value = module.keyvault.key_vault_uri }
output "iothub_hostname"     { value = module.iot.iothub_hostname }
output "event_hubs_broker"   { value = module.event_hubs.kafka_broker }
output "log_workspace_id"    { value = module.monitor.workspace_id }
