resource "azurerm_key_vault" "pass" {
  name     = "${local.prefix}-kv-valid-vault"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_key_vault" "fail" {
  name     = "invalid-kv-name"
  location = local.location
  tags     = local.common_tags
}