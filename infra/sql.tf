
resource "azurerm_mssql_server" "sql_server" {
  name                         = "blogsqlserver2025"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "H@Sh1CoR3!"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_database" "sql_db" {
  name      = "blogdb"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "S0"
}
