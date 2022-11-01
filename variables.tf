variable "default_name_prefix" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "admin_ip" {
  type = string
  description = "The IP address of the workstation administrator (a.k.a your IP address)"
}


variable "dns_zone_resource_group_name" {
  type    = string
  default = "NoResourceGroup"
}

variable "dns_zone_name" {
  type    = string
  default = "example.com"
}

variable "assing_domain_name" {
  description = "Should we assign a domain name to the public IP address?"
  default     = false
}

variable "domain_name" {
  description = "The domain name to assign to the public IP address. E.g. myhost[.dns_zone_name]"
  default     = "myhost"
}


variable "network_address_space" {
  type        = string
  description = "The address space that is used by the virtual network. E.g. 10.0.0.0/16 which is 10.0.0.0 - 10.0.255.255"
}

variable "subnet_address_space" {
  type        = string
  description = "The address space that is used by the subnet. E.g. 10.0.1.0/24 which is 10.0.1.0 - 10.0.1.255"
}

variable "resource_tag" {
  type = string
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine. E.g. Standard_DS2_v2, Check more sizes here: https://azureprice.net"
}

variable "vm_data_disks_count" {
  type        = number
  default     = 0
  description = "The number of data disks to attach to the virtual machine."
}

variable "vm_data_disk_size_gb" {
  type        = number
  default     = 200
  description = "The size of the data disk in GB"
}


variable "vm_admin_username" {
  default = "ubuntu"
  type    = string
}

variable "vm_admin_password" {
  default = "Unselfish76Daffodil65sponge19Passionate74Nifty96turtle25"
  type    = string
}

variable "linux_vm" {
  default = false
}

variable "linux_vm_ssh_auth" {
  default = false
}

variable "linux_vm_ssh_certificate_file_path" {
  type        = string
  default     = "az-vi-dev-rsa-public.key"
  description = "The path to the SSH certificate RSA public key file, e.g. my-rsa-public.key"
}

variable "linux_vm_ssh_certificate_default_username" {
  type        = string
  default     = "ubuntu"
  description = "The default username for the SSH certificate RSA public key file, e.g. ubuntu"
}


variable "windows_vm" {
  default = false
}

variable "windows_vm_install_iis" {
  default = false
}
