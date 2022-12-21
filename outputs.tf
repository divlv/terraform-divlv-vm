
output "vm_static_ip" {
  depends_on = [
    azurerm_public_ip.staticip
  ]
  # value = azurerm_nat_gateway_public_ip_association.s .appoutgoingip[0].ip_address
  value = azurerm_public_ip.staticip[*].ip_address
}


output "vm_domain_name" {
  value = var.assing_domain_name ? "${azurerm_dns_a_record.vm_domain[0].name}.${azurerm_dns_a_record.vm_domain[0].zone_name}" : "Domain name not assigned"
}
