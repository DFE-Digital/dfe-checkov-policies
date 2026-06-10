resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}rg-project-name"
  location = "uksouth"
  tags     = local.common_tags
}

resource "azurerm_resource_group" "fail" {
  name     = "${local.prefix}rg-project-name"
  location = "westeurope"
  tags     = local.common_tags
}