data "azurerm_resource_group" "rg" {
  name = "${local.prefix}-rg"
}

// PASS
// "azurerm_storage_account" has an "azurerm_storage_management_policy" with at least one rule defined
resource "azurerm_storage_account" "pass_storage_account" {
  name                     = "${local.prefix}storageaccount"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Premium"
  account_replication_type = "GRS"
}

resource "azurerm_storage_management_policy" "pass_storage_management_policy" {
  storage_account_id = azurerm_storage_account.pass_storage_account.id

  rule {
    name    = "delete-after-three-years"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = 1095
      }
    }
  }
}
// PASS

// FAIL
// "azurerm_storage_management_policy" has no rule block defined
resource "azurerm_storage_account" "fail_storage_account_management_policy_no_rule_defined" {
  name                     = "${local.prefix}storageaccount"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Premium"
  account_replication_type = "GRS"
}

resource "azurerm_storage_management_policy" "pass_storage_management_policy" {
  storage_account_id = azurerm_storage_account.fail_storage_account_management_policy_no_rule_defined.id
}
// FAIL

// FAIL
// "azurerm_storage_account" has no "azurerm_storage_management_policy" defined
resource "azurerm_storage_account" "fail_storage_account_no_management_policy_defined" {
  name                     = "${local.prefix}storageaccount"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Premium"
  account_replication_type = "GRS"
}
// FAIL
