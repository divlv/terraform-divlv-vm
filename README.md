# Terraform Module for Azure Virtual Machine
Terraform module for Azure Virtula machine spin up.

Sample usage for Linux VM:

```terraform

module "MySuperVM" {

  source = "./aegvm"

  default_name_prefix     = var.DEFAULT_NAME_PREFIX
  resource_group_location = var.AZ_RESOURCE_GROUP_LOCATION
  resource_group_name     = var.AZ_RESOURCE_GROUP
  resource_tag            = var.AZ_ENVIRONMENT_TAG

  linux_vm = true

  vm_size = "Standard_D4s_v3"

  # vm_data_disks_count = 1
  # vm_data_disk_size_gb  = 128

#  vm_admin_username = "notused" (Windows VM only)
#  vm_admin_password = "notused" (Windows VM only)

  linux_vm_ssh_auth                  = true
  linux_vm_ssh_certificate_file_path = "my-rsa-public.key"

  vm_subnet_id = azurerm_subnet.mysupersubnet.id

  assing_domain_name           = true
  dns_zone_resource_group_name = "RG1"
  dns_zone_name                = "example.com"
  domain_name                  = "mysupervm"

}

```
