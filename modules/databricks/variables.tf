variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "vnet_id" {}
variable "public_subnet_name" {}
variable "private_subnet_name" {}
variable "public_subnet_network_security_group_association_id" {
  type = string
}
variable "private_subnet_network_security_group_association_id" {
  type = string
}
variable "pep_subnet_id" {
  type = string
}
