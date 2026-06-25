resource "azurerm_resource_group" "fail" {
  name     = "${local.prefix}-resource-group"
  location = "UK South"
  tags     = local.common_tags
}

resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}-resource-group"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_management_lock" "pass_no_location" {
  name       = "test-lock"
  scope      = azurerm_resource_group.pass.id
  lock_level = "CanNotDelete"
  tags       = local.common_tags
}