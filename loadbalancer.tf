resource "azurerm_public_ip" "example" {
  name                = "PublicIPForLB"
  location            = local.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = local.location
  resource_group_name = azurerm_resource_group.resource_group.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

output "lb_public_ip" {
  value = azurerm_public_ip.example.ip_address
}