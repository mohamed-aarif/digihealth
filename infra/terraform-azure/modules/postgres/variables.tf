variable "name"      { type = string }
variable "location"  { type = string }
variable "rg_name"   { type = string }
variable "subnet_id" { type = string }
variable "sku"       { type = string default = "Standard_D4s_v3" }
variable "databases" { type = list(string) default = ["identity","patient","records","consent","iot","doctor","search","interop","ai"] }
