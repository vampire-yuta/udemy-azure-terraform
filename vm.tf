resource "azurerm_network_interface" "main" {
  name                = local.vm_network_interface
  location            = local.location
  resource_group_name = azurerm_resource_group.resource_group.name
  //  network_security_group_id = azurerm_network_security_group.main.id

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.Public.id
    private_ip_address_allocation = "Dynamic"
    //    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

//resource "azurerm_public_ip" "main" {
//  name                = var.web01-publicip
//  location                  = local.location
//  resource_group_name = azurerm_resource_group.resource_group.name
//  allocation_method   = "Static"
//}

resource "azurerm_network_security_group" "main" {
  name                = local.vm_security_group
  location            = local.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_network_security_rule" "RDP" {
  name                        = "RDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "HTTP" {
  name                        = "HTTP"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_virtual_machine" "main" {
  name                  = local.vm_name
  location              = local.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = local.vm_storage_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.vm_hostname
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
}

#resource "azurerm_virtual_machine_extension" "example" {
#  name                 = "IIS"
#  location             = var.location
#  resource_group_name  = azurerm_resource_group.resource_group.name
#  virtual_machine_name = azurerm_virtual_machine.main.name
#  publisher            = "Microsoft.Compute"
#  type                 = "CustomScriptExtension"
#  type_handler_version = "1.9"
#
#  settings = <<SETTINGS
#    {
#        "commandToExecute": "powershell.exe -Command Add-WindowsFeature Web-Server"
#    }
#SETTINGS
#}

resource "azurerm_public_ip" "bastion" {
  name                = "examplepip"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "examplebastion"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}