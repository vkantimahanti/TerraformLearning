output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "public_subnet_name" {
  value = azurerm_subnet.public.name
}

output "private_subnet_name" {
  value = azurerm_subnet.private.name
}


output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private.id
}

output "pep_subnet_id" {
  value = azurerm_subnet.pep.id
}

output "public_subnet_nsg_association_id" {
  value = azurerm_subnet_network_security_group_association.public.id
}

output "private_subnet_nsg_association_id" {
  value = azurerm_subnet_network_security_group_association.private.id
}

