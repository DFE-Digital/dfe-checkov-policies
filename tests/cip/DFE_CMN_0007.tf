data "azurerm_resource_group" "rg" {
  name = "${local.prefix}rg-core"
}

resource "azurerm_log_analytics_workspace" "pass" {
  name                = "${local.prefix}log-analytics-workspace"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  
  retention_in_days = 90
}

resource "azurerm_log_analytics_workspace" "fail" {
  name                = "${local.prefix}log-analytics-workspace"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
}