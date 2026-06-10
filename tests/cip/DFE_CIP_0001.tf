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