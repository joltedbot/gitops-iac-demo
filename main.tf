
######## Resource Group ########
module "base_resource_group" {
  source       = "./modules/resource_group"
  name         = "Lab_Shared_Resources"
  region       = var.region
  tag-owner    = var.tag-owner
  tag-project  = var.tag-project
  tag-lifetime = var.tag-lifetime
}

######## Base Environment Networking ########
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
  source                 = "./modules/network_security_group_rule"
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

module "base_rg_vnet_public_subnet_nsg_outbound_rule" {
  source                 = "./modules/network_security_group_rule"
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


######## Azure Firewall ########
module "azure_firewall_subnet" {
  source          = "./modules/subnet"
  name            = "AzureFirewallSubnet"
  resource_group  = module.base_resource_group.name
  virtual_network = module.base_virtual_network.name
  address_space   = ["10.0.3.0/24"]
}

module "public_subnet_firewall_ip_address" {
  source            = "./modules/public_ip"
  name              = "lab-firewall-ip"
  resource_group    = module.base_resource_group.name
  region            = var.region
  allocation_method = "Static"
  tag-owner         = var.tag-owner
  tag-project       = var.tag-project
  tag-lifetime      = var.tag-lifetime
}

module "public_subnet_firewall" {
  source                = "./modules/firewall"
  name                  = "lab-firewall"
  resource_group        = module.base_resource_group.name
  region                = var.region
  subnet                = module.azure_firewall_subnet.id
  ip_address            = module.public_subnet_firewall_ip_address.id
  destination_addresses = module.public_subnet_firewall_ip_address.ip
  translated_address    = module.base_environment_jump_host.private_ip_address
  tag-owner             = var.tag-owner
  tag-project           = var.tag-project
  tag-lifetime          = var.tag-lifetime
}



######## Virtual Machines ########

module "base_environment_jump_host" {
  source             = "./modules/linux_vm"
  name               = "jumphost"
  hostname           = "lab-jumphost"
  resource_group     = module.base_resource_group.name
  region             = var.region
  subnet             = module.base_public_subnet.id
  nic_name           = "jumphost-vnic"
  private_ip_address = "10.0.1.10"
  vm_size            = "Standard_B1s"
  root_user          = "lab-root"
  root_user_pub_key  = var.root_user_pub_key
  custom_data        = base64encode(file("./boot_scripts/jumphost.sh"))
  tag-owner          = var.tag-owner
  tag-project        = var.tag-project
  tag-lifetime       = var.tag-lifetime
}


module "base_environment_git_lab_runner" {
  source             = "./modules/linux_vm"
  name               = "gitlab-runner"
  hostname           = "gitlab-runner"
  resource_group     = module.base_resource_group.name
  region             = var.region
  subnet             = module.base_private_subnet.id
  nic_name           = "runner-vnic"
  private_ip_address = "10.0.2.11"
  vm_size            = "Standard_B1s"
  root_user          = "lab-root"
  root_user_pub_key  = var.root_user_pub_key
  custom_data        = base64encode(file("./boot_scripts/gitlab_runner.sh"))
  tag-owner          = var.tag-owner
  tag-project        = var.tag-project
  tag-lifetime       = var.tag-lifetime
}


module "base_environment_cloudflared_tunnel" {
  source             = "./modules/linux_vm"
  name               = "cloudflared-tunnel"
  hostname           = "cloudflared1"
  resource_group     = module.base_resource_group.name
  region             = var.region
  subnet             = module.base_private_subnet.id
  nic_name           = "tunnel-vnic"
  private_ip_address = "10.0.2.12"
  vm_size            = "Standard_B1s"
  root_user          = "lab-root"
  root_user_pub_key  = var.root_user_pub_key
  custom_data        = base64encode(file("./boot_scripts/cloudflared_tunnel.sh"))
  tag-owner          = var.tag-owner
  tag-project        = var.tag-project
  tag-lifetime       = var.tag-lifetime
}


######## Kubernetes Cluster ########
module "base_environment_aks" {
  source         = "./modules/aks"
  name           = "lab-aks"
  resource_group = module.base_resource_group.name
  region         = var.region
  subnet         = module.base_private_subnet.id
  node_pool_name = "labpool1"
  tag-owner      = var.tag-owner
  tag-project    = var.tag-project
  tag-lifetime   = var.tag-lifetime
}