data "azurerm_resource_group" "rg" {
  name = "${local.prefix}rg-core"
}

resource "azurerm_application_insights" "fail" {
  name                = "${local.prefix}-application-insights"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  application_type    = "web"
}

resource "azurerm_application_insights" "pass" {
  name                = "${local.prefix}-application-insights"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  application_type    = "web"

  sampling_percentage = 100
}