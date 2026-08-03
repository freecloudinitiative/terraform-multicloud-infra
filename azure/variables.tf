variable "location" {
  type        = string
  description = "The Azure region to deploy resources into"
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group"
  default     = "k3s-rg"
}
