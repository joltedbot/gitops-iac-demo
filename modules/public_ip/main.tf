resource "azurerm_public_ip" "vnic_ip" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = var.allocation_method
  
  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }

}