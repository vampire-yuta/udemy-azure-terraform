resource "azurerm_storage_account" "example" {
  name                     = "vamdemicstore"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account_network_rules" "test" {
  resource_group_name  = azurerm_resource_group.resource_group.name
  storage_account_name = azurerm_storage_account.example.name

  default_action             = "Allow"
  virtual_network_subnet_ids = [azurerm_subnet.Private.id]
}

resource "azurerm_storage_container" "example" {
  name                  = "tools"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "install.ps1"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "install.ps1"
}