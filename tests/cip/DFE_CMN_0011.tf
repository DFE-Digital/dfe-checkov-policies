data "azurerm_resource_group" "rg" {
  name = "${local.prefix}-rg"
}

// PASS
// "azurerm_log_analytics_workspace" has an "azurerm_log_analytics_data_export_rule" connected to an "azurerm_storage_account"
resource "azurerm_log_analytics_workspace" "pass_log_analytics_workspace" {
  name                = "${local.prefix}-log-analytics-workspace"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
}

resource "azurerm_storage_account" "pass_storage_account" {
  name                     = "${local.prefix}storageaccount"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Premium"
  account_replication_type = "GRS"
}

resource "azurerm_log_analytics_data_export_rule" "pass_log_analytics_data_export_rule" {
  name                    = "${local.prefix}-log-analytics-data-export-rule"
  resource_group_name     = data.azurerm_resource_group.rg.name
  workspace_resource_id   = azurerm_log_analytics_workspace.pass_log_analytics_workspace.id
  destination_resource_id = azurerm_storage_account.pass_storage_account.id
  table_names             = ["Example"]
}
// PASS

// FAIL
// "azurerm_log_analytics_data_export_rule" is not connected to an "azurerm_storage_account"
resource "azurerm_eventhub_namespace" "fail_eventhub_namespace" {
  name                = "${local.prefix}-eventhub-namespace"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  sku                 = "Premium"
}

resource "azurerm_log_analytics_workspace" "fail_log_analytics_workspace_no_azurerm_storage_account" {
  name                = "${local.prefix}-log-analytics-workspace"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
}

resource "azurerm_log_analytics_data_export_rule" "fail_azurerm_log_analytics_data_export_rule" {
  name                    = "${local.prefix}-log-analytics-data-export-rule"
  resource_group_name     = data.azurerm_resource_group.rg.name
  workspace_resource_id   = azurerm_log_analytics_workspace.fail_log_analytics_workspace_no_azurerm_storage_account.id
  destination_resource_id = azurerm_eventhub_namespace.fail_eventhub_namespace.id
  table_names             = ["Example"]
}
// FAIL

// FAIL
// "azurerm_log_analytics_workspace" does not have an "azurerm_log_analytics_data_export_rule"
resource "azurerm_log_analytics_workspace" "fail_log_analytics_workspace_no_azurerm_log_analytics_data_export_rule" {
  name                = "${local.prefix}-log-analytics-workspace"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
}
// FAIL
