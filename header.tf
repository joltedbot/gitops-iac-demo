terraform {

  backend "remote" {
    organization = "capacitance-ca"
    workspaces {
      name = "azure_base_environment"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.25.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }

  }

}


provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  features {}
}