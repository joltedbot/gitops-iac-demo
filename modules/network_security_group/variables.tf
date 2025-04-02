variable "name" {
  description = "The name of the network security group to create"
}

variable "resource_group" {
  description = "The name of the resrouce group to use for this resource"
}

variable "region" {
  description = "The Azure region in which to create the newtork security group"
  default     = "Canada Central"
}


// Variables to set tag fields for all resources that will use them. Should be set from the top level main.tf
variable "tag-owner" {}
variable "tag-project" {}
variable "tag-lifetime" {}
