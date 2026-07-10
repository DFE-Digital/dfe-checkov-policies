resource "azurerm_resource_group" "fail" {
  name     = "${local.prefix}-rg"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}-rg"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_consumption_budget_resource_group" "consumption_budget_resource_group" {
  name              = "${local.prefix}-consumption_budget_resource_group"
  resource_group_id = azurerm_resource_group.pass.id
  amount            = 1000

  time_period {
    start_date = "2026-01-01T00:00:00Z"
  }

  notification {
    operator  = "GreaterThan"
    threshold = 100.0

    contact_emails = [
      "example@email.com"
    ]
  }
}
