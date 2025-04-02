variable "name" {
  description = "The name of the firewall rule to create"
}

variable "resource_group" {
  description = "The name of the resrouce group to use for this resource"
}

variable "firewall" {
  description = "The firewall that this rule should be applied to"
}


variable "source_addresses" {
  description = "The source ip addresses that this rule should be applied to"
  default     = ["*"]
}


variable "destination_ports" {
  description = "The destination ports that this rule should be applied to"
}

variable "destination_addresses" {
  description = "The destination ip addresses that this rule should be applied to"
}


variable "protocols" {
  description = "The protocols that this rule should be applied to"
  default     = ["TCP", "UDP"]
}

variable "priority" {
  description = "The priority of the rule"
}


variable "action" {
  description = "The action to take for the rule. Allow or Deny"
}
