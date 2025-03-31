variable name {
    description = "The name of the resource group to create"
}

variable resource_group {
    description = "The name of the resource group to use for this virtual network"
}

variable virtual_network {
    description = "The virtual network that this subnet should reside in"
}

variable address_space {
    description = "The address space that this subnet should use. This will need to be an available range from the Virtual Network address range in which it lives"
}
