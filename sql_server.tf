# sql server
resource "azurerm_sql_server" "server" {
  name                         = local.sqlserver_name
  resource_group_name          = local.resource_group_name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = local.sqlserver_admin_name
  administrator_login_password = local.sqlserver_admin_password
}

# sql database
resource "azurerm_sql_database" "db" {
  name                = local.sqldatabase_name
  resource_group_name = local.resource_group_name
  location            = local.location
  edition             = "basic"
  server_name         = azurerm_sql_server.server.name
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                = local.sqlserver_vnet_rule
  resource_group_name = local.resource_group_name
  server_name         = azurerm_sql_server.server.name
  subnet_id = azurerm_subnet.Private.id
}

output "sqlserver_fqdn" {
  value = azurerm_sql_server.server.fully_qualified_domain_name
}