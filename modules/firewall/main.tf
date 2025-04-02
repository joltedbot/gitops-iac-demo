
resource "azurerm_firewall" "lab_firewall" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  firewall_policy_id  = azurerm_firewall_policy.lab_firewall_policy.id

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


resource "azurerm_firewall_policy" "lab_firewall_policy" {
  name                = "${var.name}-policy"
  resource_group_name = var.resource_group
  location            = var.region

  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }

}


resource "azurerm_firewall_nat_rule_collection" "lab_firewall_policy_rule_collection" {
  name                = "${var.name}-policy-rules"
  azure_firewall_name = azurerm_firewall.lab_firewall.name
  resource_group_name = var.resource_group
  priority            = 100
  action              = "Dnat"

  rule {
    name = "ssh-jump-host"

    source_addresses = var.source_addresses

    destination_ports = [
      "2222",
    ]

    destination_addresses = [
      var.ip_address
    ]

    translated_port = 22

    translated_address = var.destination_addresses

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}
