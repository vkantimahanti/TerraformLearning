# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#     ty version = "~> 3.95.0"
#     }
#   }
# }


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}


module "vnet" {
  source                = "./modules/vnet"
  name                  = var.vnet_name
  address_space         = var.vnet_address_space
  location              = var.location
  resource_group_name   = var.resource_group_name
  public_subnet_name    = var.public_subnet_name
  public_subnet_prefix  = var.public_subnet_prefix
  private_subnet_name   = var.private_subnet_name
  private_subnet_prefix = var.private_subnet_prefix
  pep_subnet_name       = var.pep_subnet_name
  pep_subnet_prefix     = var.pep_subnet_prefix
  nsg_id                = module.nsg.nsg_id 
}


module "nsg" {
  source              = "./modules/nsg"
  name                = "${var.vnet_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "storage_account" {
  source               = "./modules/storage_account"
  name                 = var.storage_account_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  subnet_id            = module.vnet.private_subnet_id
}

module "databricks" {
  source                = "./modules/databricks"
  name                  = var.databricks_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  vnet_id               = module.vnet.vnet_id
  public_subnet_name    = module.vnet.public_subnet_name
  private_subnet_name   = module.vnet.private_subnet_name
  public_subnet_network_security_group_association_id = module.vnet.public_subnet_nsg_association_id
  private_subnet_network_security_group_association_id = module.vnet.private_subnet_nsg_association_id
  pep_subnet_id = module.vnet.pep_subnet_id
}

module "dns_zone" {
  source              = "./modules/dns_zone"
  dns_zone_name       = "privatelink.azuredatabricks.net"
  resource_group_name = var.resource_group_name
  vnet_id             = module.vnet.vnet_id
}

