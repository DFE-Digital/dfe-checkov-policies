resource "azurerm_cosmosdb_account" "fail" {
  name     = "${local.prefix}-cosmosdb"
  location = local.location
  tags     = local.common_tags
}
