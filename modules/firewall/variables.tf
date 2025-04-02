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
  description = "The subnet that the firewall will be deployed to"
}

variable "ip_address" {
  description = "The public IP address that the firewall will use"
}
variable "destination_addresses" {
  description = "The destination ip addresses that this rule should be applied to"
}


variable "source_addresses" {
  description = "The source ip addresses that the ssh firewall rule should be applied to"
  default     = ["*"]
}


// Variables to set tag fields for all resources that will use them. Should be set from the top level main.tf
variable "tag-owner" {}
variable "tag-project" {}
variable "tag-lifetime" {}
