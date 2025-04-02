
resource "azurerm_firewall" "lab_firewall" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group

  tags = {
    owner    = var.tag-owner
    project  = var.tag-project
    lifetime = var.tag-lifetime
  }

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration {
    name                 = "public"
    subnet_id            = var.subnet
    public_ip_address_id = var.ip_address
  }
}