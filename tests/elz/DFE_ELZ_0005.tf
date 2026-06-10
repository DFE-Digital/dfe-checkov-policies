data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${local.prefix}-rg"
  location = local.location
  tags     = local.common_tags
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${local.prefix}-log-analytics-workspace"
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_storage_account" "storage_account" {
  name                = "${local.prefix}-storageaccount"
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_key_vault" "kv" {
  name                = "${local.prefix}-kv"
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_application_insights" "app_insights" {
  name                = "${local.prefix}-appinsights"
  resource_group_name = azurerm_resource_group.rg.name
}

// FAIL - "azurerm_cognitive_account"
resource "azurerm_cognitive_account" "fail_cognitive_account" {
  name                = "${local.prefix}-cognitiveaccount-fail"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "CognitiveServices"
  sku_name            = "S0"
}
// FAIL - "azurerm_cognitive_account"

// PASS - "azurerm_cognitive_account"
resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  name                       = "${local.prefix}-monitor_diagnostic_setting"
  target_resource_id         = azurerm_cognitive_account.pass_cognitive_account.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id

  enabled_log {
    category = "Audit"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_cognitive_account" "pass_cognitive_account" {
  name                = "${local.prefix}-cognitiveaccount"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "CognitiveServices"
  sku_name            = "S0"
}
// PASS - "azurerm_cognitive_account"

// FAIL - "azurerm_machine_learning_workspace"
resource "azurerm_machine_learning_workspace" "fail_machine_learning_workspace" {
  name                    = "${local.prefix}-mlworkspace"
  location                = local.location
  resource_group_name     = azurerm_resource_group.rg.name
  storage_account_id      = data.azurerm_storage_account.storage_account.id
  key_vault_id            = data.azurerm_key_vault.kv.id
  application_insights_id = data.azurerm_application_insights.app_insights.id
  sku_name                = "Basic"

  lifecycle {
    ignore_changes = [tags]
  }

  identity {
    type = "SystemAssigned"
  }
}
// FAIL - "azurerm_machine_learning_workspace"

// PASS - "azurerm_machine_learning_workspace"
resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  name                       = "${local.prefix}-monitor_diagnostic_setting"
  target_resource_id         = azurerm_machine_learning_workspace.pass_machine_learning_workspace.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id

  enabled_log {
    category = "Audit"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_machine_learning_workspace" "pass_machine_learning_workspace" {
  name                    = "${local.prefix}-mlworkspace"
  location                = local.location
  resource_group_name     = azurerm_resource_group.rg.name
  storage_account_id      = data.azurerm_storage_account.storage_account.id
  key_vault_id            = data.azurerm_key_vault.kv.id
  application_insights_id = data.azurerm_application_insights.app_insights.id
  sku_name                = "Basic"

  lifecycle {
    ignore_changes = [tags]
  }

  identity {
    type = "SystemAssigned"
  }
}
// PASS - "azurerm_machine_learning_workspace"