terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

module "module_dev"{
        
        #location of the main and variables file
        source = "./modules"

        # prefix provided before every resource as standard naming convention
        prefix = "mydevenv"

        # resource group name
        rgname = prefix + "rg1"

        # resource group location
        rglocation = "eastus"

        # vnet details 
        vnet = prefix + "vnet"
        vnet_cidr_range = "10.10.0.0/16"

        # subnet details
        subnet = prefix + "subnet"
        subnet_cidr_range = "10.10.1.0/24"

        # network security group details
        nsg = prefix + "nsg"

        # network security rule
        nsr = prefix + "nsr"

        # network interface
        ni = prefix + "ni"

        # virtual machine
        vm = prefix + "vm"

}