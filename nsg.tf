////////////////////////////
//  Network security group
////////////////////////////

# ATTENTION! This NSG will be a part of separate network setup.

# resource "azurerm_network_security_group" "defaultnsgopen" {
#   name                = "${var.default_name_prefix}nsg"
#   resource_group_name = var.resource_group_name
#   location            = var.resource_group_location

#   security_rule {
#     name                       = "Allow_Admin"
#     priority                   = 1000
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = var.admin_ip
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "Allow_HTTP"
#     priority                   = 2000
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "Allow_HTTPS"
#     priority                   = 2010
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "443"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }


#   security_rule {
#     name                       = "Close_other_ports"
#     priority                   = 4000
#     direction                  = "Inbound"
#     access                     = "Deny"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }


#   tags = {
#     environment = var.resource_tag
#   }
# }
