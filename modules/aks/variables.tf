variable "name" {
  description = "The name of the firewall to create"
}

variable "resource_group" {
  description = "The name of the resource group to use for this resource"
}

variable "region" {
  description = "The Azure region in which to create the resource"
  default     = "Canada Central"
}

variable "subnet" {
  description = "The subnet ID to use for the AKS clusters nodes"
}







// Variables to set tag fields for all resources that will use them. Should be set from the top level main.tf
variable "tag-owner" {}
variable "tag-project" {}
variable "tag-lifetime" {}