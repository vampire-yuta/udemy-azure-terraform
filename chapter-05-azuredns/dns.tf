resource "azurerm_dns_zone" "example-public" {
  name                = "vamdemicsystem.net"
  resource_group_name = azurerm_resource_group.resource_group.name
}

