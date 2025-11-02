variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID used by Key Vault and OIDC auth."
########################################
# Root (envs/dev) – Variables (DECLARED)
########################################

variable "name" {
  description = "Base name prefix for resources"
  type        = string
  default     = "digihealth-dev"
}

variable "rg_name" {
  description = "Resource group name used by network module"
  type        = string
  default     = "rg-digihealth-dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

# Networking
variable "address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "aks_subnet_prefix" {
  description = "AKS subnet CIDR"
  type        = string
  default     = "10.10.1.0/24"
}

# AKS
variable "aks_node_count" {
  description = "AKS node count"
  type        = number
  default     = 3
}

variable "aks_node_vm_size" {
  description = "AKS node VM size"
  type        = string
  default     = "Standard_D4s_v5"
}

# APIM
variable "apim_publisher_name" {
  description = "APIM publisher name"
  type        = string
  default     = "DigiHealth"
}

variable "apim_publisher_email" {
  description = "APIM publisher email"
  type        = string
  default     = "devnull@example.com"
}

variable "apim_sku" {
  description = "APIM SKU (Developer/Basic/Standard/Premium)"
  type        = string
  default     = "Developer"
}

# PostgreSQL
variable "postgres_sku" {
  description = "PostgreSQL SKU / size hint (used by module)"
  type        = string
  default     = "Standard_D4s_v3"
}