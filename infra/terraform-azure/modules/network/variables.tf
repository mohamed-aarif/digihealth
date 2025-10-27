variable "name"         { type = string }
variable "rg_name"      { type = string }
variable "location"     { type = string }
variable "address_space"{ type = list(string) default = ["10.10.0.0/16"] }
variable "subnet_aks"   { type = string default = "10.10.1.0/24" }
variable "subnet_data"  { type = string default = "10.10.2.0/24" }
