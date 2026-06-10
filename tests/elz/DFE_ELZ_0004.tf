data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${local.prefix}-rg"
  location = local.location
  tags     = local.common_tags
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

resource "azurerm_cognitive_account" "fail_cognitive_account" {
  name                = "${local.prefix}-cognitiveaccount"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "CognitiveServices"
  sku_name            = "S0"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_cognitive_account" "exempted_cognitive_account" {
  #checkov:skip=DFE_ELZ_0004 - Exempted resource - Cognitive Account
  name                = "${local.prefix}-cognitiveaccount-exempted"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "CognitiveServices"
  sku_name            = "S0"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_machine_learning_workspace" "fail_ml_workspace" {
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

resource "azurerm_machine_learning_workspace" "exempted_ml_workspace" {
  #checkov:skip=DFE_ELZ_0004 - Exempted resource - Machine Learning Workspace
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