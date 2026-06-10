data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "${local.prefix}rg-project-name"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_key_vault" "pass" {
  name                        = "${local.prefix}-kv-project-name"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  rbac_authorization_enabled = true
}

resource "azurerm_key_vault" "fail" {
  name                        = "${local.prefix}-kv-project-name"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"
}