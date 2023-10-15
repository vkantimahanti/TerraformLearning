# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}

    subscription_id =  ""
    client_id = ""
    client_secret = ""
    tenant_id = ""
}


# Create a resource group
resource "azurerm_resource_group" "rg1" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"

  tags = {
    project = "terraform test"
  }

}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.vnet}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  address_space       = ["${var.vnet_cidr_range}"]
}


resource "azurerm_subnet" "subnet1" {
  name                 = "${var.subnet}"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["${var.subnet_cidr_range}"]
}


resource "azurerm_network_security_group" "nsg1" {
  name                = "${var.nsg}"
  location            = "${azurerm_resource_group.rg1.location}"
  resource_group_name = "${azurerm_resource_group.rg1.name}"
  }

resource "azurerm_network_security_rule" "rdp" {
  name                        = "${var.rdp}"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.rg1.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg1.name}"
}


resource "azurerm_subnet_network_security_group_association" "nsg_snet_aso" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}


resource "azurerm_network_interface" "ni1" {
  name                = "${var.ni}"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}



resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "${var.vm}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.ni1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
