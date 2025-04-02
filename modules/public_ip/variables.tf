variable "name" {
  description = "The name of the IP Address to create"
}

variable "resource_group" {
  description = "The name of the resource group to use for this ip address"
}

variable "region" {
  description = "The Azure region in which to create the resource group"
  default     = "Canada Central"
}

variable "allocation_method" {
  description = "The allocation method for the public IP address. Can be either Static or Dynamic."
  default     = "Dynamic"
}


// Variables to set tag fields for all resources that will use them. Should be set from the top level main.tf
variable "tag-owner" {}
variable "tag-project" {}
variable "tag-lifetime" {}
