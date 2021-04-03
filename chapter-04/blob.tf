resource "azurerm_storage_account" "example" {
  name                     = "vamdemicstore"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  // 本来はPublicにはしないと思う
  //  allow_blob_public_access = true
  allow_blob_public_access = false
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
  //  container_access_type = "blob"
}

resource "azurerm_storage_blob" "example" {
  name                   = "install.ps1"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "install.ps1"
}

data "azurerm_storage_account_sas" "example" {
  connection_string = azurerm_storage_account.example.primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"

  resource_types {
    service   = false
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2018-03-21"
  expiry = "2022-03-21"

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
  }
}