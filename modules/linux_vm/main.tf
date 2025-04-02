

resource "azurerm_network_interface" "vnic" {
  name                = var.nic_name
  location            = var.region
  resource_group_name = var.resource_group

  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }


  ip_configuration {
    name                          = "${var.name}-nic"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    primary                       = true
  }

}

resource "azurerm_linux_virtual_machine" "labvm" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  size                = var.vm_size
  admin_username      = var.root_user
  computer_name       = var.hostname
  custom_data         = var.custom_data

  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }



  network_interface_ids = [
    azurerm_network_interface.vnic.id
  ]

  admin_ssh_key {
    username   = var.root_user
    public_key = var.root_user_pub_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}