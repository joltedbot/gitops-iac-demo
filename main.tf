
module "base_resource_group" {
  source       = "./modules/resource_group"
  name         = "Lab_Shared_Resources"
  region       = var.region
  tag-owner    = var.tag-owner
  tag-project  = var.tag-project
  tag-lifetime = var.tag-lifetime
}

module "base_virtual_network" {
  source         = "./modules/virtual_network"
  name           = "Base_Shared_Resources_Vnet"
  resource_group = module.base_resource_group.name
  address_space  = ["10.0.0.0/16"]
  region         = var.region
  tag-owner      = var.tag-owner
  tag-project    = var.tag-project
  tag-lifetime   = var.tag-lifetime
}

module "base_public_subnet" {
  source          = "./modules/subnet"
  name            = "Base_Shared_Resources_Public_Subnet"
  resource_group  = module.base_resource_group.name
  virtual_network = module.base_virtual_network.name
  address_space   = ["10.0.1.0/24"]
}

module "base_private_subnet" {
  source          = "./modules/subnet"
  name            = "Base_Shared_Resources_Private_Subnet"
  resource_group  = module.base_resource_group.name
  virtual_network = module.base_virtual_network.name
  address_space   = ["10.0.2.0/24"]
}

module "base_rg_vnet_public_subnet_nsg" {
  source         = "./modules/network_security_group"
  name           = "Base_Shared_Resources_Private_Subnet"
  resource_group = module.base_resource_group.name
  region         = var.region
  tag-owner      = var.tag-owner
  tag-project    = var.tag-project
  tag-lifetime   = var.tag-lifetime
}

module "base_rg_vnet_public_subnet_nsg_default_rule" {
  source                 = "./modules/network_security_rule"
  name                   = "default_public_nsg_rule_allow_ssh"
  resource_group         = module.base_resource_group.name
  network_security_group = module.base_rg_vnet_public_subnet_nsg.name
  tag-owner              = var.tag-owner
  tag-project            = var.tag-project
  tag-lifetime           = var.tag-lifetime

  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_port_range     = "22"
  destination_address_prefix = "*"
}

module "base_rg_vnet_public_subnet_nsg_default_rule" {
  source                 = "./modules/network_security_rule"
  name                   = "default_public_nsg_rule_outbound_allow_https"
  resource_group         = module.base_resource_group.name
  network_security_group = module.base_rg_vnet_public_subnet_nsg.name
  tag-owner              = var.tag-owner
  tag-project            = var.tag-project
  tag-lifetime           = var.tag-lifetime

  priority                   = 200
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_port_range     = "443"
  destination_address_prefix = "*"
}