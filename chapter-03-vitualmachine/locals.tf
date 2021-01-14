locals {
  // Global Settings
  resource_group_name = "udemy-azure-lesson-chapter03"
  location            = "japaneast"

  // VNet
  vnet_name = "udemy-virtual-network"
  vm_name   = "udemy-virtual-machine-windowsserver-2019"

  // VM
  vm_hostname          = "app"
  vm_security_group    = "udemy-network-security-group"
  vm_network_interface = "udemy-vm-network-interface"
  vm_storage_name      = "udemy-vm-os-storage"
}
