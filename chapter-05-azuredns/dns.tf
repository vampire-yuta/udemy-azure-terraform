resource "azurerm_dns_zone" "example-public" {
  name                = "vamdemicsystem.net"
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_dns_a_record" "lb" {
  name                = "udemy"
  zone_name           = azurerm_dns_zone.example-public.name
  resource_group_name = azurerm_resource_group.resource_group.name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.example.id
  # records = ["10.0.2.4"]
}

output "azure_dns_nameservers" {
  value = azurerm_dns_zone.example-public.name_servers
t }