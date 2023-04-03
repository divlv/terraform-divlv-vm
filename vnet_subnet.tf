///////////////////////////
//  Virtual network for VM
///////////////////////////

# The Network will be a part of separate setup. E.g. this VM may be a part of existing VNet.

# resource "azurerm_virtual_network" "vnet" {
#   name = "${var.default_name_prefix}vmnet"
#   address_space = [
#     var.network_address_space
#   ]

#   resource_group_name = var.resource_group_name
#   location            = var.resource_group_location

#   tags = {
#     environment = "dev"
#   }
# }


# # Creating Default Subnet
# resource "azurerm_subnet" "subnet" {
#   name                 = "${var.default_name_prefix}subnet"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes = [
#     var.subnet_address_space
#   ]
# }

# resource "azurerm_subnet_network_security_group_association" "vnet-subnet" {
#   subnet_id                 = azurerm_subnet.subnet.id
#   network_security_group_id = azurerm_network_security_group.defaultnsgopen.id
# }



////////////////////////////////////////////////////////////////////////////////////
// Give subnet a static outgoing IP (if needed) for easier filter/firewall traffic
////////////////////////////////////////////////////////////////////////////////////

#resource "azurerm_nat_gateway" "subnetgw" {
#  count               = (var.static_outgoing_ip && var.create_app_subnet) ? 1 : 0
#  name                = "${var.app_name}subnetgw"
#  resource_group_name = var.resource_group_name
#  location            = var.resource_group_location
#  sku_name            = "Standard"
#}
#
#resource "azurerm_nat_gateway_public_ip_association" "subnetgwip" {
#  count                = (var.static_outgoing_ip && var.create_app_subnet) ? 1 : 0
#  nat_gateway_id       = azurerm_nat_gateway.subnetgw[0].id
#  public_ip_address_id = azurerm_public_ip.appoutgoingip[0].id
#}
#
#resource "azurerm_subnet_nat_gateway_association" "subnetgwsubnet" {
#  count          = (var.static_outgoing_ip && var.create_app_subnet) ? 1 : 0
#  subnet_id      = azurerm_subnet.subnet[0].id
#  nat_gateway_id = azurerm_nat_gateway.subnetgw[0].id
#}
