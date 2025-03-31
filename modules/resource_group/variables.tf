variable "name" {
  description = "The name of the resource group to create"
}

variable "region" {
  description = "The Azure region in which to create the resource group"
  default     = "Canada Central"
}


// Variables to set tag fields for all resources that will use them. Should be set from the top level main.tf
variable "tag-owner" {}
variable "tag-project" {}
variable "tag-lifetime" {}
