// Global login variables set with HCP Terraform variables
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

// Defaults for the lab environment
variable "region" {
  default     = "Canada Central"
  description = "The region to use for all resources unless there is a reason to override per resource"
}


// Tags that should be used by all resources
variable "tag-owner" {
  description = "Who is the owner of these resources. Likely whoever is running this template. This lets people know who to contact for any questions about the live resrouces"
  default     = "Dave White"
}

variable "tag-project" {
  description = "What project is this lab being created for. Why do the live resources exist and by extension their importance."
  default     = "Base Environment Demo"
}

variable "tag-lifetime" {
  description = "How long should these resources live. Can they be destroyed or should they live indefinitely?"
  default     = "Ephemeral"
}

variable "root_user_pub_key" {
  description = "The Public Key of an SSH key pair to use for the root user for this VM.  Set this via the terraform workspace variables."
}

variable "source_addresses" {
  description = "The source ip addresses that the ssh firewall rule should be applied to"
}

variable "cloudflare_api_token" {
  description = "The API token to use for the Cloudflare provider"
}

variable "zone_id" {
  description = "The zone id to use for the Cloudflare provider"

}
