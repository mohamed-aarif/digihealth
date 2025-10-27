variable "name" { type = string }
variable "location" { type = string }
variable "rg_name" { type = string }
variable "subnet_id" { type = string }
variable "node_vm_size" { type = string default = "Standard_D4s_v5" }
variable "node_count" { type = number default = 3 }