
resource "azurerm_firewall_network_rule_collection" "example" {
  name                = var.name
  resource_group_name = var.resource_group
  azure_firewall_name = var.firewall

  priority = var.priority
  action   = var.action

  rule {
    name                  = "${var.name}-rule"
    source_addresses      = var.source_addresses
    destination_ports     = var.destination_ports
    destination_addresses = var.destination_addresses
    protocols             = var.protocols
  }
}
