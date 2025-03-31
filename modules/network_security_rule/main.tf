resource "azurerm_network_security_rule" "lab_base_nsg_rule" {
    name = var.name
    resource_group_name = var.resource_group
    network_security_group_name = var.network_security_group

    priority                   = var.priority
    direction                  = var.direction
    access                     = var.access
    protocol                   = var.protocol
    source_address_prefix      = var.source_address_prefix
    destination_port_range     = var.destination_port_range
    destination_address_prefix = var.destination_address_prefix
}
