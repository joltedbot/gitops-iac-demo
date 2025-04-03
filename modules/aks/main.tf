resource "azurerm_kubernetes_cluster" "lab-cluster" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group
  dns_prefix          = "ionlab"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B1s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    owner    = var.tag-owner
    project  = var.tag-project
    lifetime = var.tag-lifetime
  }

}


resource "azurerm_kubernetes_cluster_node_pool" "lab-cluster-nodes" {
  name                  = var.node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.lab-cluster.id
  vm_size               = "Standard_B1s"
  node_count            = 1

  tags = {
    owner    = var.tag-owner
    project  = var.tag-project
    lifetime = var.tag-lifetime
  }

}