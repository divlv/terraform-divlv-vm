//////////////////////////////////////
//  DNS records for VM, if any:
//////////////////////////////////////

resource "azurerm_dns_a_record" "vm_domain" {
  count               = var.assing_domain_name ? 1 : 0
  depends_on          = [azurerm_public_ip.vmip]
  name                = var.domain_name
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group_name
  ttl                 = 300
  records             = [azurerm_public_ip.vmip.ip_address]
}
