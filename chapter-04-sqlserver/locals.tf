locals {
  // Global Settings
  resource_group_name = "udemy-azure-lesson"
  location            = "japaneast"

  // VNet
  vnet_name = "udemy-virtual-network"
  vm_name   = "udemy-virtual-machine-windowsserver-2019"

  // VM
  vm_hostname          = "app"
  vm_security_group    = "udemy-network-security-group"
  vm_network_interface = "udemy-vm-network-interface"
  vm_storage_name      = "udemy-vm-os-storage"

  // SQL Server
  sqlserver_name           = "udemy-sqlserver"
  sqlserver_admin_name     = "udemyadmin"
  sqlserver_admin_password = "P@ssw0rd!1233"
  sqlserver_vnet_rule      = "udemy-sqlserver-vnet-rule"

  // SQL Database
  sqldatabase_name = "udemy-lesson-db"
}
