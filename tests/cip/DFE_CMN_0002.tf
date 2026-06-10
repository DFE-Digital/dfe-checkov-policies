resource "azurerm_resource_group" "fail" {
  name     = "${local.prefix}-resource-group"
  location = local.location
  tags     = merge(local.common_tags, { "Service Offering" = null })
}

resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}-resource-group"
  location = local.location
  tags     = local.common_tags
}