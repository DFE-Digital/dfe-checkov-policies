resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}rg-valid-group"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "fail" {
  name     = "invalid-rg-name"
  location = local.location
  tags     = local.common_tags
}