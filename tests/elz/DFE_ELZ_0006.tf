## Test Boilerplate
resource "azurerm_resource_group" "rg" {
  name     = "${local.prefix}-rg"
  location = local.location
  tags     = local.common_tags
}

data "azurerm_network_security_group" "nsg" {
  name                = "${local.prefix}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_virtual_network" "vnet" {
  name                = "${local.prefix}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
}
## Test Boilerplate

## Pass
resource "azurerm_subnet" "pass_azurerm_subnet" {
  name                 = "${local.prefix}-azurerm-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  network_security_group_id_wo = data.azurerm_network_security_group.nsg.id
}
## Pass

## Fail
resource "azurerm_subnet" "fail_azurerm_subnet_missing_wo_nsg" {
  name                 = "${local.prefix}-azurerm-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "fail_azurerm_subnet_has_association_resource" {
  name                 = "${local.prefix}-azurerm-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  network_security_group_id_wo = data.azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.fail_azurerm_subnet_has_association_resource.id
  network_security_group_id = data.azurerm_network_security_group.nsg.id
}
## Fail