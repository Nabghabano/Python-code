resource "azurerm_resource_group" "grafana_rg" {
  name     = var.grafanaresourcegroup
  location = var.location
}


# Create VM in Grafana resource group
resource "azurerm_network_interface" "main" {
  name                = var.ni
  location            = "var.location"
  resource_group_name = "networking"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = [azurerm_subnet.internal.id]  # Adjust to access the first subnet ID from the module
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the network security group with security rules
resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = "var.location"
  resource_group_name = "networking"

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

# Associate the network security group with the network interface of the virtual machine
resource "azurerm_network_interface" "main11" {
  name                = "my-network-interface"
  location            = "var.location"
  resource_group_name = "networking"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = [azurerm_subnet.internal.id]
    private_ip_address_allocation = "Dynamic"
  }

}

# The rest of your existing virtual machine configuration remains unchanged
resource "azurerm_virtual_machine" "main" {
  name                  = "my-vmnvg"
  location              = "var.location"
  resource_group_name   = "networking"
  network_interface_ids = [azurerm_network_interface.main11.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

