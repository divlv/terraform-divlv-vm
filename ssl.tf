// bApp HTTPS Domain binding //////////////////////////////////////

#resource "azurerm_app_service_custom_hostname_binding" "app" {
#  count = var.create_app_dns_name ? 1 : 0
#  depends_on = [
#    azurerm_dns_txt_record.app_domain_txt
#  ]
#
#  hostname            = "${var.app_dns_name}.${var.dns_zone_name}"
#  app_service_name    = azurerm_app_service.app.name
#  resource_group_name = var.resource_group_name
#
#  ssl_state  = "SniEnabled"
#  thumbprint = var.ssl_certificate_thumbprint
#}
