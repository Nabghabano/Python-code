#create resource group for networking
resource "azurerm_resource_group" "networking_rg" {
  name     = var.networkingresourcegroup
  location = var.location
}

# Create NSGs
resource "azurerm_network_security_group" "nsg" {
  count               = 3
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}


# Create VNets and subnets
resource "azurerm_virtual_network" "main" {
  count = 3
  name                = "fgihkj-${count.index}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "internal" {
  name                 = "fgihj-"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main[count.index].name
  address_prefixes     = ["10.0.2.0/24"]
}

