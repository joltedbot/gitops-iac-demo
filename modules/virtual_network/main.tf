resource "azurerm_virtual_network" "lab_primary_vnet" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  address_space       = var.address_space

  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }
}   