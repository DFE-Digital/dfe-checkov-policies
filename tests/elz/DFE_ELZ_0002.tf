resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}rg-project-name"
  location = "uksouth"
  tags     = local.common_tags
}

resource "azurerm_management_lock" "pass_no_location" {
  name       = "test-lock"
  scope      = azurerm_resource_group.pass.id
  lock_level = "CanNotDelete"
  tags       = local.common_tags
}

resource "azurerm_resource_group" "fail" {
  name     = "${local.prefix}rg-project-name"
  location = "westeurope"
  tags     = local.common_tags
}