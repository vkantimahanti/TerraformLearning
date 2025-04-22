resource "azurerm_databricks_workspace" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  sku                         = "premium"

  custom_parameters {
    virtual_network_id        = var.vnet_id
    public_subnet_name        = var.public_subnet_name
    private_subnet_name       = var.private_subnet_name
    public_subnet_network_security_group_association_id = var.public_subnet_network_security_group_association_id
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
  }
}


resource "azurerm_private_endpoint" "databricks_pe" {
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pep_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_databricks_workspace.this.id
    subresource_names              = ["databricks_ui_api"]
    is_manual_connection           = false
  }
}