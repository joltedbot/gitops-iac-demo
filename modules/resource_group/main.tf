resource "azurerm_resource_group" "lab-rg" {
  name     = var.name
  location = var.region
  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }
}