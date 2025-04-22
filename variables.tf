variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "vnet_name" {}

variable "vnet_address_space" {
  type = list(string)
}

variable "public_subnet_name" {}

variable "public_subnet_prefix" {
  type = list(string)
}

variable "private_subnet_name" {}

variable "private_subnet_prefix" {
  type = list(string)
}

variable "pep_subnet_name" {}

variable "pep_subnet_prefix" { 
  type = list(string) 
}


variable "databricks_name" {}

variable "storage_account_name" {}

# variable "nsg_id" {
#   type = string
# }
