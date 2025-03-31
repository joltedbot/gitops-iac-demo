resource "azurerm_subnet" "lab_subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group
  virtual_network_name = var.virtual_network
  address_prefixes     = var.address_space
}