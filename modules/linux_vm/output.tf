output "vm_public_ip_address" {
  value = azurerm_public_ip.vm_vnic_ip.ip_address
}

output "vm_private_ip_address" {
  value = azurerm_linux_virtual_machine.labvm.private_ip_address
}