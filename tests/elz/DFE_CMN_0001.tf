resource "azurerm_resource_group" "fail" {
  name     = "${local.prefix}rg-core"
  location = local.location
  tags     = merge(local.common_tags, { Environment = null })
}

resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}rg-core"
  location = local.location
  tags     = local.common_tags
}