output "vnet_id" {
  value = module.vnet.vnet_id
}

output "public_subnet_id" {
  value = module.vnet.public_subnet_id
}

output "private_subnet_id" {
  value = module.vnet.private_subnet_id
}


output "pep_subnet_id" {
  value = module.vnet.pep_subnet_id
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "databricks_workspace_url" {
  value = module.databricks.workspace_url
}

output "storage_account_id" {
  value = module.storage_account.storage_account_id
}


output "nsg_id" {
  value = module.nsg.nsg_id
}