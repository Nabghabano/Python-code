
variable "grafanaresourcegroup" {
  type        = string
  default = "grafana"
  description = "RG name in Azure"
}

variable "networkingresourcegroup" {
  type        = string
  default = "network"
  description = "RG name in Azure"
}


variable "storageresourcegroup" {
  type        = string
  default = "grafana"
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  default = "eastus"
  description = "Resources location in Azure"
}

variable "resource_group_name_storage" {
  type        = string
  default = "storage"
  description = "RG name in Azure"
}

variable "resource_group_name" {
  type        = string
  default = "networking"
  description = "RG name in Azure"
}

variable "storageaccount" {
  type = string
  default = "mystorage1512233"

}

variable "logs" {
  type = string
  default = "log workplace"
}
variable "nsg_name" {
    type = string
    description = "network secuirty group name"
}

variable "sname" {
    type = string
    description = "network secuirty group name"
}

variable "vn_name" {
    type = string
    description = "network secuirty group name"
}


variable "vm_name" {
    type = string
    description = "network secuirty group name"
}

variable "ni" {
    type = string
    default = " network"
    description = "network secuirty group name"
}
