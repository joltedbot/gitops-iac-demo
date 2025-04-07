resource "cloudflare_ruleset" "zone_custom_firewall" {
  zone_id     = var.zone_id
  name        = "Web Server Custom Firewall Rules"
  description = ""
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [{
    ref         = "block_non_default_ports"
    description = "Block ports other than 80 and 443"
    expression  = "(http.request.full_uri contains \"ionlab.davewhite.xyz\" and ip.src ne ${var.source_addresses[0]})"
    action      = "block"
  }]

}