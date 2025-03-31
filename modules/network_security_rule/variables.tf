variable "name" {
  description = "The name of the resource group to create"
}

variable "resource_group" {
  description = "The name of the resource group to use for this virtual network"
}

variable "network_security_group" {
  description = "The NSG to attach this rule to"
}

variable "priority" {
  description = "The priority to give this rule relative to any other in the network security group"
  default     = 100
}

variable "direction" {
  description = "Is this an Inbound or Outbound rule"
}

variable "access" {
  description = "Should the rule Allow or Deny matching traffic"
}

variable "protocol" {
  description = "Protocol to match with this rule: Possible Values: Tcp, Udp, Icmp, Esp, Ah or *"
}

variable "destination_port_range" {
  description = "The range of destination ports that the rule should match. Can be a value 22 or a range 20-52"
  default     = "*"
}

variable "destination_address_prefix" {
  description = "A CIDR rage or single destination address that the rule should match"
  default     = "*"
}

variable "source_address_prefix" {
  description = "A CIDR rage or single source address that the rule should match"
  default     = "*"
}

// Variables to set tag fields for all resources that will use them. Should be set from the top level main.tf
variable "tag-owner" {}
variable "tag-project" {}
variable "tag-lifetime" {}
