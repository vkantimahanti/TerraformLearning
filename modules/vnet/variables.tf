variable "name" {}
variable "address_space" { type = list(string) }
variable "location" {}
variable "resource_group_name" {}
variable "public_subnet_name" {}
variable "public_subnet_prefix" { type = list(string) }
variable "private_subnet_name" {}
variable "private_subnet_prefix" { type = list(string) }
variable "pep_subnet_name" {}
variable "pep_subnet_prefix" { type = list(string) }
variable "nsg_id" { type = string }
