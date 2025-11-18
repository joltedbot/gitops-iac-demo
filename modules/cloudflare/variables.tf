variable "zone_id" {
  description = "The zone id to use for the Cloudflare provider"

}

variable "source_addresses" {
  description = "The source ip addresses that the ssh firewall rule should be applied to"
}

variable "destination_domain_name" {
  description = "The target domain name for the web server"
}
