resource "azurerm_public_ip" "vm_vnic_ip" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = var.allocation_method
  sku                 = "Standard"

  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }

}