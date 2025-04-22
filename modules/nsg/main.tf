resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# 🔐 Optional: Allow inbound HTTPS
resource "azurerm_network_security_rule" "inbound_https" {
  name                        = "AllowHTTPSManaged"
  priority                    = 150
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# 🚀 Required for Databricks VNet injection

# To AzureDatabricks (443, 3306, 8443-8451)
resource "azurerm_network_security_rule" "databricks_to_webapp" {
  name                        = "AllowToAzureDatabricks"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443", "3306", "8443-8451"]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureDatabricks"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# To SQL (3306)
resource "azurerm_network_security_rule" "databricks_to_sql" {
  name                        = "AllowToSql"
  priority                    = 210
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "Sql"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# To Azure Storage (443)
resource "azurerm_network_security_rule" "databricks_to_storage" {
  name                        = "AllowToStorage"
  priority                    = 220
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "Storage"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# To Event Hub (9093)
resource "azurerm_network_security_rule" "databricks_to_eventhub" {
  name                        = "AllowToEventHub"
  priority                    = 230
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "9093"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "EventHub"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}