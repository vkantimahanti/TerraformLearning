variable "prefix"{
    type = string
    description = "standard prefix used across the variables"
}


variable "rgname"{
    type = string
    description = "used for naming resource group"
}


variable "rglocation"{
    type = string
    description = "used for selecting the location"
    default = "eastus"
}


variable "vnet"{
    type = string
    description = "used for selecting the network"
}


variable "vnet_cidr_range"{
    type = string
    description = "used for allocating a cidr range in virutal network"

}



variable "subnet"{
    type = string
    description = "used for providing the subnet range"
}


variable "subnet_cidr_range"{
    type = string
    description = "used for allocating a cidr range in subnet network"
}



variable "nsg"{
    type = string
    description = "used for identifying the network security group"
}


variable "nsr"{
    type = string
    description = "used for defining the network security rule"
}


variable "ni"{
    type = string
    description = "used for selecting the network interface"
}

variable "vm"{
    type = string
    description = "used for selecting hte location"
}
