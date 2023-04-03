###################################################
# Common purpose Virtual Machine Terraform Module
###################################################


resource "azurerm_network_interface" "vmnic" {
  name                = "${var.default_name_prefix}vm-nic"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location


  ip_configuration {
    name                          = "${var.default_name_prefix}vm-ipconfig"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vmip.id
  }

  tags = {
    environment = var.resource_tag
  }

}


##################### WINDOWS #####################################

resource "azurerm_windows_virtual_machine" "winvm" {
  count               = var.windows_vm ? 1 : 0
  depends_on          = [azurerm_network_interface.vmnic]
  name                = "${var.default_name_prefix}vm"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size

  admin_username = var.vm_admin_username
  admin_password = var.vm_admin_password


  network_interface_ids = [
    azurerm_network_interface.vmnic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    environment = var.resource_tag
  }
}


resource "azurerm_virtual_machine_extension" "vm_extension_install_iis" {
  count                      = var.windows_vm_install_iis ? 1 : 0
  name                       = "vm_extension_install_iis"
  virtual_machine_id         = azurerm_windows_virtual_machine.winvm[0].id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
SETTINGS
}


##################### LINUX ############################


locals {
  admin_ssh_keys = {
    key1 = {
      username   = var.linux_vm_ssh_certificate_default_username
      public_key = file(var.linux_vm_ssh_certificate_file_path)
    }
  }
}






resource "azurerm_linux_virtual_machine" "linuxvm" {
  count               = var.linux_vm ? 1 : 0
  depends_on          = [azurerm_network_interface.vmnic]
  name                = "${var.default_name_prefix}vm"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size


  network_interface_ids = [
    azurerm_network_interface.vmnic.id
  ]


  admin_username = var.vm_admin_username
  admin_password = var.vm_admin_password

  disable_password_authentication = var.linux_vm_ssh_auth

  dynamic "admin_ssh_key" {
    for_each = var.linux_vm_ssh_auth ? [1] : []
    content {
      username   = lookup(local.admin_ssh_keys["key1"], "username", null)
      public_key = lookup(local.admin_ssh_keys["key1"], "public_key", null)
    }
  }



  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202209200"
  }

  os_disk {
    name                 = "${var.default_name_prefix}vmosdisk1"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }


  tags = {
    environment = var.resource_tag
  }
}


resource "azurerm_managed_disk" "datadisk" {
  count                = var.vm_data_disks_count
  name                 = format("${var.default_name_prefix}vmdisk-%d", count.index)
  resource_group_name  = var.resource_group_name
  location             = var.resource_group_location
  create_option        = "Empty"
  disk_size_gb         = var.vm_data_disk_size_gb
  storage_account_type = "Standard_LRS"

  tags = {
    environment = var.resource_tag
  }
}

# Iterate over the list of disks and attach them to the VM
resource "azurerm_virtual_machine_data_disk_attachment" "datadisksforvm" {
  count              = var.vm_data_disks_count
  managed_disk_id    = azurerm_managed_disk.datadisk[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.linuxvm[0].id
  lun                = 1 + count.index
  caching            = "ReadWrite"
}
