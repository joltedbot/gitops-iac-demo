resource "azurerm_network_security_group" "lab_base_vnet_nsg" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group

  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }
}