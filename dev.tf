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
        rgname = "mydevenv-rg1"

        # resource group location
        rglocation = "eastus"

        # vnet details 
        vnet = "mydevenv-vnet"
        vnet_cidr_range = "10.10.0.0/16"

        # subnet details
        subnet = "mydevenv-subnet"
        subnet_cidr_range = "10.10.1.0/24"

        # network security group details
        nsg = "mydevenv-nsg"

        # remote desktop details
        rdp = "mydevenv-rdp"

        # network security rule
        nsr = "mydevenv-nsr"

        # network interface
        ni = "mydevenv-ni"

        # virtual machine
        vm = "mydevenv-vm"

}
