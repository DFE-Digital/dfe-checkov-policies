resource "azurerm_resource_group" "rg" {
  name     = "${local.prefix}-rg"
  location = local.location
  tags     = local.common_tags
}

data "azurerm_virtual_network" "vnet" {
  name                = "${local.prefix}-virtual-network"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                                 = "${local.prefix}-azurerm-subnet"
  resource_group_name                  = azurerm_resource_group.rg.name
  virtual_network_name                 = data.azurerm_virtual_network.vnet.name
  address_prefixes                     = ["10.0.1.0/24"]
  network_security_group_id_wo         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example/providers/Microsoft.Network/networkSecurityGroups/nsg-example"
  network_security_group_id_wo_version = "1"
}

resource "azurerm_subnet_network_security_group_association" "fail_azurerm_subnet" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example/providers/Microsoft.Network/networkSecurityGroups/nsg-example"
}