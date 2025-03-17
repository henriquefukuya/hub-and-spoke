# Definição do provedor do Azure
provider "azurerm" {
  features {}
}

# Resource Group do HUB
resource "azurerm_resource_group" "hub_rg" {
  name     = "rg-hub"
  location = "East US"
}

# Virtual Network do HUB
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet do Firewall no HUB
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "snet-firewall"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Resource Group do SPOKE
resource "azurerm_resource_group" "spoke_rg" {
  name     = "rg-spoke"
  location = "East US"
}

# Virtual Network do SPOKE
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "vnet-spoke"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = ["10.1.0.0/16"]
}

# Subnet do Aplicativo no SPOKE
resource "azurerm_subnet" "app_subnet" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.spoke_rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Peering entre HUB e SPOKE
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peer-hub-to-spoke"
  resource_group_name          = azurerm_resource_group.hub_rg.name
  virtual_network_name         = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_vnet.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peer-spoke-to-hub"
  resource_group_name          = azurerm_resource_group.spoke_rg.name
  virtual_network_name         = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
}
