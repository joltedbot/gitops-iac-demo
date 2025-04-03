output "client_certificate" {
  value     = module.base_environment_aks.client_certificate
  sensitive = true
}