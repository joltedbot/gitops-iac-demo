resource "azurerm_public_ip" "vm_vnic_ip" {
  name                = var.ip_name
  location            = var.region
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"

  tags = {
    Owner    = var.tag-owner
    Project  = var.tag-project
    lifetime = var.tag-lifetime
  }

}

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
    name                          = "vnic-1"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.vm_vnic_ip.id
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