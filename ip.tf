//////////////////////////////////////
//  Public (and static) IP addresses.
//////////////////////////////////////

#
# Static IP form VirtualMachine
#
resource "azurerm_public_ip" "vmip" {
  name                = "${var.default_name_prefix}vmip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.resource_tag
  }
}
